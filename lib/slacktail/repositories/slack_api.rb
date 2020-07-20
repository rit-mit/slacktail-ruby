require 'slack'

# require_relative './monkey_patches/slack.rb'
# require_relative './cache.rb'
require_relative './slack_api/client.rb'
require_relative './slack_api/channel.rb'
require_relative './slack_api/history.rb'
require_relative './slack_api/user.rb'

module Slacktail
  module Repository
    module SlackApi; end
  end
end
