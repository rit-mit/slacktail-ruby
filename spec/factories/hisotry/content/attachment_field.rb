FactoryBot.define do
  factory :history_content_attachment_field, class: ::Model::History::Content::AttachmentField do
    title { ::Faker::Lorem.words(number: 2) }
    value { ::Faker::Lorem.characters(number: 10) }
    short { [true, false].sample }
  end
end
