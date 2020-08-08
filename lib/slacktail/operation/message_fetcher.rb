module Operation
  class MessageFetcher
    def self.call(channel)
      raise ArgumentError if channel&.id.nil? || channel&.account&.name.nil?

      channel_messages_of(channel).map do |message|
        Model::History::History.new(channel: channel, message: message)
      end
    end

    private

    def self.channel_messages_of(channel)
      token = channel.account.token
      raise ArgumentError, "No slack token for account: #{channel.account.name}" if token.nil?

      messages = Repository::SlackApi::History::MessageList.fetch_messages(token, channel.id)
      ::Slacktail.debug("History messages!!: #{channel.account.name}/#{channel.name} #{messages}")

      messages
    end
  end
end
