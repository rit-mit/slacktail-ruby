module Slacktail
  module Model
    module History
      class History
        attr_accessor :channel, :message

        def initialize(channel:, message:)
          @channel = channel
          @message = message
        end

        def property
          @property ||= Property.convert(message, token: channel.account.token)
        end

        def contents_list
          @contents_list ||= Converter.convert(message, token: channel.account.token)
        end

        def filtered?
          text = contents_list&.text&.text
          return false unless text

          channel.parameter&.include&.each do |include|
            return false if text.include? include
          end

          channel.parameter&.exclude&.each do |exclude|
            return true if text.include? exclude
          end

          false
        end
      end
    end
  end
end
