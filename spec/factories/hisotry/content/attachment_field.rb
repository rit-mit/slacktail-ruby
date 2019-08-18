FactoryBot.define do
  factory :history_content_attachment_field, class: ::Slacktail::History::Content::AttachmentField do
    title { ::Faker::Lorem.words(2) }
    value { ::Faker::Lorem.characters(10) }
    short { [true, false].sample }
  end
end
