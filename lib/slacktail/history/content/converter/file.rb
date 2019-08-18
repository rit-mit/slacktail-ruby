require 'catpix'

module Slacktail
  module History
    module Content
      module Converter
        class File < Base
          def convert_url_private_download!(content_object, content)
            mime_type = content['mimetype']
            content_object.content_text = if mime_type.include? 'image'
                                            convert_authorized_image_of content['url_private_download']
                                          elsif mime_type.include? 'text'
                                            convert_text content['url_private_download']
                                          else
                                            ''
                                          end
          end

          private

          def convert_authorized_image_of(url)
            image_params = {
              limit_x: 0.5,
              resolution: 'high',
              http_header: { 'Authorization' => "Bearer #{options[:token]}" }
            }
            ::Catpix.build_image_string(url, image_params)
          rescue ImageMagickError => error
            pp "ImageMagickError: #{error}"
          end

          def convert_text(url)
            client = Faraday.new(url: url)
            res = client.get do |req|
              req.headers['Authorization'] = "Bearer #{options[:token]}"
            end

            res.body.gsub(/\r\n/, "\n").force_encoding(Encoding::UTF_8)
          end
        end
      end
    end
  end
end
