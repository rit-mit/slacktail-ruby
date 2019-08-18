FactoryBot.define do
  factory :history_content_file, class: ::Slacktail::History::Content::File do
    url_private_download { ::Faker::Internet.url }
    content_text { ::Faker::Lorem.words(3) }
    name { ::Faker::Lorem.Pokemon.name }
  end
end
