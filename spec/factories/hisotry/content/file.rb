FactoryBot.define do
  factory :history_content_file, class: ::Model::History::Content::File do
    url_private_download { ::Faker::Internet.url }
    content_text { ::Faker::Lorem.words(number: 3) }
    name { ::Faker::Lorem.Pokemon.name }
  end
end
