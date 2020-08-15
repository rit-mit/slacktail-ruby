FactoryBot.define do
  factory :history_content_text, class: ::Model::History::Content::Text do
    text { ::Faker::Lorem.words(number: 3) }
  end
end
