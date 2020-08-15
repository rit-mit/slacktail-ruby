module Model
  module History
    module Content
      module Converter
        class Attachment < Base
          def convert_fields!(content_object, content)
            return if content.is_a? Array

            content_object.fields ||= []
            content['fields'].each do |field|
              content_object.fields.push(AttachmentField.convert(field).first)
            end
          end

          def convert_image_url!(content_object, content_val)
            content_object.image_context_text = convert_image_of content_val
          end

          private

          def convert_image_of(url)
            options = {
              limit_x: 0.5,
              resolution: 'high',
              http_header: {}
            }
            ::Catpix.build_image_string(url, options)
          rescue StandardError
            ''
          end
        end
      end
    end
  end
end
