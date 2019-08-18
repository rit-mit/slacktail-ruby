module SlackApi
  module Client
    def client
      @client ||= ::Slack::Web::Client.new
    end
  end
end
