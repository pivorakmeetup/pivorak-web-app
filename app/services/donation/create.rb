class Donation
  class Create < ApplicationService
    def initialize(params)
      @data    = decoded_data(params[:data])
      @user_id = params[:user_id]
    end

    def call
      return successful_donation if status_success?

      Rails.logger.error error_msg

      { status: false }
    end

    private

    attr_reader :data, :user_id

    def successful_donation
      create_donation

      { status: true }
    end

    def create_donation
      @donation ||= Donation.create(donation_params)
    end

    def donation_params
      {
        user_id: user_id,
        amount:  data['amount']
      }
    end

    def status_success?
      data.present? && data['status'] == SUCCESS_STATUS
    end

    def error_msg
      return I18n.t('errors.donation_not_decoded') unless data.present?

      "#{liqpay_status_msg} Status: '#{data['status']}'."
    end

    def liqpay_status_msg
      I18n.t "liqpay.status.#{data['status']}"
    end

    def decoded_data(data)
      Liqpay::Charge::Decode.(data)
    end

    SUCCESS_STATUS = 'success'.freeze
  end
end
