module Slacktail
  module History
    class Property
      attr_accessor :time, :user_name

      def initialize(time:, user_name:)
        @time = time
        @user_name = user_name
      end

      def self.convert(from_object, options = {})
        converter = Converter.new(from_object, options)
        params = {
          time: converter.time,
          user_name: from_object.username || converter.user_name
        }

        new(params)
      end

      class Converter
        attr_accessor :from_object, :token
        def initialize(from_object, options = {})
          @from_object = from_object
          @token = options.fetch(:token, nil)
        end

        def time
          ts = from_object.ts
          return nil if ts.nil?

          time = Time.at(ts.to_i)
          # TODO: I18nを使う
          time.strftime('%Y年%m月%d日 %H:%M:%S')
        end

        def user_name
          raise ArgumentError, 'No slack token for user name' if token.nil?

          if from_object.bot_id
            ::SlackApi::User::Info.bot_name_by(token, from_object.bot_id)
          else
            ::SlackApi::User::Info.name_by(token, from_object.user)
          end
        end
      end
    end
  end
end
