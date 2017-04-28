module Liqpay
  module Charge
    class Handler < ApplicationService
      def initialize(data)
        @data = decoded_data(data)
      end

      def call
        return data_not_decoded if data.blank?

        ActiveRecord::Base.transaction do
          if LIQPAY_SUCCESS_STATUS.include?(status)
            success
          elsif status == 'failure'
            error
          else
            other_status
          end
        end
      end

      private

      attr_reader :data

      def status
        @status ||= data.present? ? data['status'] : nil
      end

      def create_donation
        Donation.create(donation_params)
      rescue => e
        Rails.logger.info e.full_messages
      end

      def donation_params
        {
          user_id:    data['customer'].to_i,
          amount:     data['amount'],
          payment_id: data['payment_id']
        }
      end

      def success
        create_donation if creating_available?

        { status: STATUS_SUCCESS }
      end

      def creating_available?
        donation_with_payment_id_absent?
      end

      def donation_with_payment_id_absent?
        Donation.find_by_payment_id(data['payment_id']).blank?
      end

      def error
        Rails.logger.error notification_msg

        { status: STATUS_ERROR }
      end

      def other_status
        Rails.logger.info notification_msg

        { status: STATUS_NOTIFICATION }
      end

      def data_not_decoded
        Rails.logger.error I18n.t('errors.donation_not_decoded')

        { status: STATUS_ERROR }
      end

      def notification_msg
        "#{liqpay_status_msg} Status: '#{data['status']}'."
      end

      def liqpay_status_msg
        I18n.t "liqpay.status.#{data['status']}"
      end

      def decoded_data(data)
        ::Liqpay::Charge::Decode.(data)
      end

      STATUS_SUCCESS        = 'success'.freeze
      STATUS_ERROR          = 'error'.freeze
      STATUS_NOTIFICATION   = 'state_notification'.freeze
      LIQPAY_SUCCESS_STATUS = [
        'success'.freeze,
        'sandbox'.freeze,
        'wait_accept'.freeze
      ].freeze
    end
  end
end
