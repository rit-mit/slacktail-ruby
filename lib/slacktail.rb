require 'config'

config_root = File.expand_path('../config', __dir__)
Config.load_and_set_settings(Config.setting_files(config_root, ENV['ENVIRONMENT']) || 'development')

require_relative './monkey_patches/slack.rb'
require_relative './slacktail/loggable.rb'
require_relative './slacktail/cache.rb'
require_relative './slacktail/haml.rb'
require_relative './slacktail/repository.rb'
require_relative './slacktail/model.rb'
require_relative './slacktail/operation.rb'

module Slacktail
  extend Loggable

  def fetch_and_print
    Operation::Tailer.call
  end
  module_function :fetch_and_print
end
