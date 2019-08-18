require 'config'

config_root = File.expand_path('../config', __dir__)
Config.load_and_set_settings(Config.setting_files(config_root, ENV['ENVIRONMENT']) || 'development')

require_relative './loggable.rb'

require_relative './slack_api.rb'
require_relative './slacktail/account.rb'
require_relative './slacktail/channel.rb'
require_relative './slacktail/history.rb'
require_relative './slacktail/tailer.rb'
require_relative './slacktail/presenter.rb'
require_relative './slacktail/config_reader.rb'

module Slacktail
  extend Loggable
end
