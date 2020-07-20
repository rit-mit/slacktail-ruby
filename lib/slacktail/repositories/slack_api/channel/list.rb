require 'digest/md5'

module Slacktail
  module Repository
    module SlackApi
      module Channel
        class List
          KVS_KEY_CHANNEL_LIST = 'CHANNEL_LIST'.freeze
          KVS_KEY_PREFIX_CHANNEL_NAME = 'CHANNEL_NAME_'.freeze

          include Client

          attr_accessor :token
          def initialize(token)
            @token = token
          end

          def fetch
            channel_list = Cache.fetch(cache_key)

            if channel_list.nil?
              channel_list = fetch_from_api
              Cache.set(cache_key, channel_list)
            end
            channel_list
          end

          def reload_list
            channel_list = fetch_from_api
            Cache.set(cache_key, channel_list)

            channel_list
          end

          private

          def cache_key
            "#{KVS_KEY_CHANNEL_LIST}-#{Digest::MD5.hexdigest(token)}"
          end

          def fetch_from_api
            response = client.channels_list(token: token)
            return [] unless valid_response? response

            response['channels'].each_with_object({}) do |channel, result|
              result[channel['name']] = channel['id']
            end
          end

          def valid_response?(response)
            return false if response.nil?
            return false if response['channels']&.count&.zero?

            true
          end
        end
      end
    end
  end
end
