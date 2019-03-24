# frozen_string_literal: true

class BulkEmailSender < ApplicationService
  BULK_SIZE = 100

  def initialize(mailer_klass:, method_name:, scope:)
    @mailer_klass = mailer_klass
    @method_name = method_name
    @scope = scope
  end

  def call
    scope.each_slice(BULK_SIZE).with_index do |objects, index|
      objects.each do |object|
        mailer_klass.public_send(method_name, object).deliver_later(wait: index.hour)
      end
    end
  end

  private

  attr_reader :mailer_klass, :method_name, :scope
end
