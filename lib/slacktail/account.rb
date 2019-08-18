require 'hashie'

module Slacktail
  class Account
    attr_accessor :name, :token

    def initialize(name:, token:)
      @name = name
      @token = token
    end

    def self.build(name:, token: nil)
      token ||= tokens_from_config.select do |token_config|
        token_config['name'] == name
      end.first.fetch('token')

      raise ArgumentError, "No slack token for account: #{name}" if token.nil?

      new(name: name, token: token)
    end

    def self.tokens_from_config
      api_token_file_path = ::Settings.slack.api_token_file_path

      if !api_token_file_path.nil? && File.exist?(api_token_file_path)
        ::Hashie::Mash.load(api_token_file_path).fetch('slack_tokens')
      elsif ::Settings.slack.api_token
        { 'name' => 'default', 'token' => ::Settings.slack.api_token }
      else
        raise ArgumentError, "No slack token: api_token_file_path #{api_token_file_path}"
      end
    end
  end
end
