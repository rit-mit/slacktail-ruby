module Model
  module History
    module Content
      class Attachment < Base
        attribute :pretext
        attribute :text
        attribute :image_url
        attribute :image_context_text
        attribute :title
        attribute :fields
      end
    end
  end
end
