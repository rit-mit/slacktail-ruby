require 'parallel'

module Operation
  class Tailer
    def self.call
      new.call
    end

    # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength
    def call
      queues = Queue.new
      queues.push :lock

      Parallel.each(channels, in_threads: channels.count) do |channel|
        loop.with_index do |_, i|
          sleep channel.tail_wait_time if i.positive?

          tail(channel, queues)
        rescue StandardError => e
          pp "rescue #{channel.full_name}"
          puts 'rescue!'.fg('#FF0000')
          pp e.class
          pp e.message
          pp e.backtrace
        ensure
          queues.push :lock
        end
      end
    end
    # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength

    def tail(channel, queues)
      histories = MessageFetcher.call(channel)
      if histories.blank? || (histories.is_a?(Array) && histories.count.zero?)
        channel.increase_tail_wait_time
        return false
      end

      channel.reset_tail_wait_time

      lock = queues.pop
      histories.sort_by { |history| history.property.time }.each do |history|
        puts presenter.call(history) || ''
      end
      queues.push lock

      true
    end

    private

    def presenter
      @presenter ||= Presenter.new
    end

    def channels
      @channels ||= ConfigReader.call
    end
  end
end
