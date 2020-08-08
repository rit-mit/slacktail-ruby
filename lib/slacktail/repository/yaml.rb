require 'hashie'

module Repository
  class Yaml
    def self.load(yaml_file_path, target_elm)
      yaml = ::Hashie::Mash.load(yaml_file_path)
      yaml.fetch(target_elm, nil)
    end
  end
end
