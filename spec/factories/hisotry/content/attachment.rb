FactoryBot.define do
  factory :history_content_attachment, class: ::Model::History::Content::Attachment do
    pretext { ::Faker::Lorem.words(number: 2) }
    text { ::Faker::Lorem.words(number: 3) }
    image_url { "#{::Faker::Internet.url}.png" }
    image_context_text { ::Faker::Lorem.words(number: 3) }
    title { ::Faker::Lorem.words(number: 2) }
    fields { build_collection :history_content_attachment_field, 3 }
  end
end
