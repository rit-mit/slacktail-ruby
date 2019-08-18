FactoryBot.define do
  factory :history_content_attachment, class: ::Slacktail::History::Content::Attachment do
    pretext { ::Faker::Lorem.words(2) }
    text { ::Faker::Lorem.words(3) }
    image_url { "#{::Faker::Internet.url}.png" }
    image_context_text { ::Faker::Lorem.words(3) }
    title { ::Faker::Lorem.words(2) }
    fields { build_collection :history_content_attachment_field, 3 }
  end
end
