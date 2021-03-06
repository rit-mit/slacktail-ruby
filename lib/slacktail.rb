require 'config'
require 'zeitwerk'

config_root = File.expand_path('../config', __dir__)
Config.load_and_set_settings(Config.setting_files(config_root, ENV['ENVIRONMENT']) || 'development')

require_relative './monkey_patches/slack.rb'
require_relative './monkey_patches/haml.rb'

loader = Zeitwerk::Loader.new
loader.push_dir('./lib/slacktail/')
loader.setup

module Slacktail
  extend Loggable

  def fetch_and_print
    Operation::Tailer.call
  end
  module_function :fetch_and_print
end
