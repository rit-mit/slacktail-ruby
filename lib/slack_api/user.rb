require 'digest/md5'

module SlackApi
  module User
    class Info
      extend ::SlackApi::Client

      KVS_KEY_PREFIX_USER_NAME = 'USER_NAME_'.freeze

      class << self
        def bot_name_by(token, user_id)
          name_by(token, user_id, is_bot: true)
        end

        def name_by(token, user_id, is_bot: false)
          return '' if user_id.nil? || user_id == ''

          kvs_key = "#{KVS_KEY_PREFIX_USER_NAME}-#{user_id}-#{Digest::MD5.hexdigest(token)}"
          user_name = ::Cache.fetch(kvs_key)

          if user_name.nil?
            user_name = get_username_from_api(token, user_id, is_bot)
            ::Cache.set(kvs_key, user_name)
          end
          user_name
        end

        def get_username_from_api(token, user_id, is_bot = false)
          if is_bot
            response = client.bots_info(bot: user_id, token: token)
            response.bot.name
          else
            response = client.users_info(user: user_id, token: token)
            response.user.name
          end
        end
      end
    end
  end
end
