module Model
  module History
    module Content
      module Converter
        class Text < Base
          def convert(message)
            content_objects = super
            content_objects.first
          end

          def convert_text!(content_object, content)
            converted = content.dup
            converted.gsub!(/.*<@([A-Z0-9]{9})>.*/) do |_|
              user_id = Regexp.last_match(1)
              '@' + SlackApi::User::Info.name_by(options[:token], user_id)
            end

            converted.gsub!(/.*<#[A-Z0-9]{9}\|([^>]+)>.*/) do |_|
              channel_name = Regexp.last_match(1)
              '#' + channel_name
            end

            content_object.text = converted if content_object.respond_to? :text
          end
        end
      end
    end
  end
end
