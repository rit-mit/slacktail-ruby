module Slacktail
  module History
    module Content
      module Converter
        class Base
          attr_accessor :options
          def initialize(options = {})
            @options = options
          end

          def self.convert(message, options = {})
            new(options).convert(message)
          end

          # rubocop:disable Metrics/AbcSize
          def convert(message)
            contents = if message.is_a? Array
                         message.dup
                       else
                         [message]
                       end

            contents.map do |content|
              content_class.new.tap do |content_object|
                if content.is_a? Hash
                  content.each do |content_type, _|
                    call_converter(content_object, content_type, content)
                  end
                else
                  # TODO: textの場合だけ特殊なのを整理する
                  content_type = content_class.name.split('::').last.downcase
                  call_converter(content_object, content_type, content)
                end
              end
            end
          end
          # rubocop:enable Metrics/AbcSize

          def call_converter(content_object, content_type, content)
            if respond_to?("convert_#{content_type}!")
              send("convert_#{content_type}!", content_object, content)
            elsif content_object.respond_to?("#{content_type}=")
              content_object.send("#{content_type}=", content[content_type])
            end

            content_object
          end

          def content_class
            @content_class ||= self.class.name.gsub(/::Converter/, '').constantize
          end
        end
      end
    end
  end
end
