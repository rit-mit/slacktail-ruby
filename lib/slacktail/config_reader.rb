require 'hashie'

module Slacktail
  class ConfigReader
    @tokens = nil

    def self.build_channels
      new.build_channels
    end

    def build_channels
      yaml.map do |params|
        params['channels'].map do |param_in_yaml|
          build_channel(params['account'], param_in_yaml)
        end
      end.flatten
    end

    def build_channel(account_name, param_in_yaml)
      channel_parameter = ::Slacktail::Channel::Parameter.new

      channel_parameter.attributes.each do |attribute, _|
        channel_parameter.send("#{attribute}=", param_in_yaml[attribute]) unless param_in_yaml[attribute].nil?
      end

      ::Slacktail::Channel::Channel.new(
        name: param_in_yaml['name'],
        account: ::Slacktail::Account.build(name: account_name),
        parameter: channel_parameter
      )
    end

    private

    def yaml
      yaml = ::Hashie::Mash.load(::Settings.channels_yaml)
      yaml.fetch('channels_config', nil)
    end
  end
end
