module Slack
  module Web
    module Faraday
      module Request
        private

        # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity
        def request(method, path, options)
          # optionにtokenが含まれていた場合は、そちらを優先するように修正
          token_for_req = token
          token_for_req = options[:token] if token_for_req.nil? && !options.fetch(:token, nil).nil?
          options = options.merge(token: token_for_req)
          # 修正終了
          #

          response = connection.send(method) do |request|
            case method
            when :get, :delete
              request.url(path, options)
            when :post, :put
              request.path = path
              request.body = options unless options.empty?
            end
            request.options.merge!(options.delete(:request)) if options.key?(:request)
          end
          response.body
        end
        # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity
      end
    end
  end
end
