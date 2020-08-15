module Repository
  module SlackApi
    module History
      module Parameter
        KVS_KEY_PREFIX_HISTORY_LATEST = 'HISTORY_LATEST_'.freeze

        def generate_parameter(channel_id, resume = true)
          # oldestの決定
          oldest = resume ? get_oldest(channel_id) : ''

          # latestの決定
          latest = generate_latest

          {
            channel:   channel_id,
            latest:    latest,
            oldest:    oldest, # キャッシュ等を使って最後に取得した時間にしたい
            count:     5,      # ポーリングするので多くなくていい
            inclusive: true,   # 取得したメッセージのLatest・Oldestのtimestampを入れるか
            unreads:   true,   # 新規メッセージの数を入れるか
          }
        end

        def save_latest(channel_id, latest)
          kvs_key = "#{KVS_KEY_PREFIX_HISTORY_LATEST}#{channel_id}"
          Cache.set(kvs_key, latest)
        end

        private

        def get_oldest(channel_id)
          kvs_key = "#{KVS_KEY_PREFIX_HISTORY_LATEST}#{channel_id}"
          Cache.get(kvs_key).to_i
        end

        def generate_latest
          # latestは常に現在時刻
          Time.now.to_i
        end
      end
    end
  end
end
