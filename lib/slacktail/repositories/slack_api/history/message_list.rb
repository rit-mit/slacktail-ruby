require 'ostruct'

module Slacktail
  module Repository
    module SlackApi
      module History
        class MessageList
          extend Client
          extend History::Parameter

          class << self
            def fetch_messages(token, channel_id)
              params_for_fetch = generate_parameter(channel_id)

              fetch_messages_from_api(token, params_for_fetch) do |history|
                if history['messages']&.count&.positive?
                  save_latest(channel_id, history['latest'])
                end
              end
            end

            def fetch_messages_from_api(token, params)
              params[:token] = token
              history_message = client.conversations_history(params)
              return if history_message.nil?

              yield(history_message)

              history_message['messages'].map do |message|
                # APIからのレスポンスにはchannel_idが付いてないので、付けておく
                message['channel_id'] = params[:channel]
                Repository::SlackApi::History::Message.new(message)
              end
            end
          end
        end
      end
    end
  end
end
