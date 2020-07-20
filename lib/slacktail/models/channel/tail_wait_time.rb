module Slacktail
  module Model
    module Channel
      module TailWaitTime
        def tail_wait_time
          @tail_wait_time ||= Settings.tail_wait_time.default_sec
        end

        def increase_tail_wait_time
          return tail_wait_time if tail_wait_time >= Settings.tail_wait_time.max_sec

          @tail_wait_time += Settings.tail_wait_time.increase_sec
        end

        def reset_tail_wait_time
          @tail_wait_time = Settings.tail_wait_time.default_sec
        end
      end
    end
  end
end
