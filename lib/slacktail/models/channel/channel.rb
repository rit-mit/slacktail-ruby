module Slacktail
  module Model
    module Channel
      class Channel
        attr_accessor :name, :account, :parameter

        include TailWaitTime

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
          channel_list = Repository::SlackApi::Channel::List.new(account.token)
          list = channel_list.fetch

          list.fetch(name, '')
        end
      end
    end
  end
end
