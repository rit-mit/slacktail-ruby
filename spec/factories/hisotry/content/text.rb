FactoryBot.define do
  factory :history_content_text, class: ::Slacktail::History::Content::Text do
    text { ::Faker::Lorem.words(3) }
  end
end
