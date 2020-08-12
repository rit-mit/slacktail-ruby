FactoryBot.define do
  factory :account, class: ::Model::Account do
    name { ::Faker::Lorem.characters(number: 12) }
    token { ::Faker::Lorem.characters(number: 32) }

    initialize_with do
      ::Model::Account.new(name, token)
    end
  end
end
