module Operation
  class ConfigReader
    @tokens = nil

    def self.call
      new.call
    end

    def call
      yaml.map do |params|
        params['channels'].map do |param_in_yaml|
          build_channel(params['account'], param_in_yaml)
        end
      end.flatten
    end

    private

    def build_channel(account_name, param_in_yaml)
      channel_parameter = Model::Channel::Parameter.new

      channel_parameter.attributes.each do |attribute, _|
        channel_parameter.send("#{attribute}=", param_in_yaml[attribute]) unless param_in_yaml[attribute].nil?
      end

      Model::Channel::Channel.new(
        name: param_in_yaml['name'],
        account: Model::Account.build(name: account_name),
        parameter: channel_parameter
      )
    end

    private

    def yaml
      @yaml ||= Repository::Yaml.load(::Settings.channels_yaml, 'channels_config')
    end
  end
end
