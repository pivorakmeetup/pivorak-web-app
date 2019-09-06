# frozen_string_literal: true

class GraphqlController < ActionController::API
  InvalidAuthToken = Class.new(StandardError)

  rescue_from InvalidAuthToken do |error|
    render json: { error: { message: error.message } }
  end

  rescue_from ActiveRecord::RecordNotFound do |error|
    render json: { error: { message: error.message } }
  end

  def execute
    result = Api::Schema.execute(query, variables: variables, context: context, operation_name: operation_name)
    render json: result
  rescue StandardError => error
    raise error unless Rails.env.development?

    handle_error_in_development error
  end

  private

  def variables
    @variables ||= ensure_hash(params[:variables])
  end

  def query
    params.require(:query)
  end

  def operation_name
    params[:operationName]
  end

  def context
    @context ||= {
      current_user: current_user
    }
  end

  def current_user
    @current_user ||= User.find(current_user_id)
  end

  def current_user_id
    token = request.headers['Authorization'].try(:split, 'Bearer ').try(:second)

    invalid_auth_token_error! unless token

    JWT.decode(token, Rails.application.secrets.secret_key_base).dig(0, 'user_id')
  rescue JWT::DecodeError => error
    invalid_auth_token_error!(error.message)
  end

  def invalid_auth_token_error!(message = 'Invalid Authroization Token')
    raise InvalidAuthToken, message
  end

  # Handle form data, JSON body, or a blank value
  def ensure_hash(ambiguous_param)
    case ambiguous_param
    when String
      if ambiguous_param.present?
        ensure_hash(JSON.parse(ambiguous_param))
      else
        {}
      end
    when Hash, ActionController::Parameters
      ambiguous_param
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{ambiguous_param}"
    end
  end

  def handle_error_in_development(error)
    logger.error error.message
    logger.error error.backtrace.join("\n")

    render json: { error: { message: error.message, backtrace: error.backtrace }, data: {} }, status: 500
  end
end
