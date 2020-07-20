require 'active_model'
require 'active_support'

module Slacktail
  module Model
    module History
      class ContentList
        include ::ActiveModel::Model
        include ::ActiveModel::Attributes

        attribute :text
        attribute :attachments
        attribute :files
      end

      class Converter
        attr_accessor :options
        def initialize(options = {})
          @options = options
        end

        def self.convert(channel_message, options = {})
          new(options).convert_from(channel_message)
        end

        def convert_from(channel_message)
          content_list = ContentList.new
          channel_message.to_h.map do |attr, each_content|
            klass = converter_class(attr)
            next if klass.nil?
            next unless content_list.respond_to? "#{attr}="

            content_list.send("#{attr}=", klass.convert(each_content, options))
          end

          content_list
        end

        def converter_class(content_type)
          Object
            .const_get('Slacktail')
            .const_get('History')
            .const_get('Content')
            .const_get('Converter')
            .const_get(content_type.to_s.singularize.capitalize)
        rescue NameError
        end
      end
    end
  end
end
