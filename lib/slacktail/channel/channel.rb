module Slacktail
  module Channel
    class Channel
      attr_accessor :name, :account, :parameter

      include ::Slacktail::Channel::TailWaitTime

      def initialize(name:, account:, parameter:)
        @name = name
        @account = account
        @parameter = parameter
      end

      def id
        @id ||= fetch_id_by(name)
      end

      def full_name
        "#{account.name}:#{name}"
      end

      private

      def fetch_id_by(name)
        channel_list = ::SlackApi::Channel::List.new(account.token)
        list = channel_list.fetch

        if list.fetch(name, nil).nil?
          # 見つからなかった場合は、再取得してみる
          list = channel_listreload_list
        end

        list.fetch(name, '')
      end
    end
  end
end
