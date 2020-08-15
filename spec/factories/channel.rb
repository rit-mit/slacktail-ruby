FactoryBot.define do
  factory :channel, class: ::Model::Channel::Channel do
    name { ::Faker::Lorem.characters(number: 16) }
    account { build :account}
    parameter { build :channel_parameter }

    initialize_with do
      ::Model::Channel::Channel.new(name: name, account: account, parameter: parameter)
    end
  end
end
