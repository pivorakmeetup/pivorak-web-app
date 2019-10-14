# frozen_string_literal: true

class HttpClient
  attr_reader :client
  extend Forwardable

  delegate %i[get put post delete] => :client

  def initialize(args = {})
    @client = HTTPClient.new
    @client.debug_dev = STDERR if args[:debug]
  end
end
