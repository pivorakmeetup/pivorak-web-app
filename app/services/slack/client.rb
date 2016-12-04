module Slack
  class Client

    class AlreadyInTeam < StandardError; end

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
       raise_error unless body['ok']
      body['ok']
    end

    private

    attr_reader :url, :params, :headers, :debug, :http_client, :body

    def default_params
      {
          token: Rails.application.secrets.slack.fetch('token')
      }
    end

    def raise_error
      raise AlreadyInTeam if body['error'] == 'already_in_team'
    end
  end
end
