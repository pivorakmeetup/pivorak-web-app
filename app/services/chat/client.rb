# frozen_string_literal: true

module Chat
  class Client
    class ChatError < StandardError; end

    def initialize(args)
      @url         = args.fetch(:url)
      @params      = args[:params]  || {}
      @headers     = args[:headers] || {}
      @debug       = args[:debug]
      @http_client = HttpClient.new(args)
    end

    def call
      response = http_client.get(url, default_params.merge(params), headers)
      @body = JsonParser.call(response.body)

      raise_error!(body['error']) if error?

      true
    end

    private

    attr_reader :url, :params, :headers, :debug, :http_client, :body

    def default_params
      {
        token: ENV['SLACK_TOKEN']
      }
    end

    def raise_error!(msg)
      raise ChatError, msg
    end

    def error?
      !body['ok']
    end
  end
end
