module Slacktail
  module Repository
    module SlackApi
      module Client
        def client
          @client ||= ::Slack::Web::Client.new
        end
      end
    end
  end
end
