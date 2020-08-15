FactoryBot.define do
  factory :channel_parameter, class: ::Model::Channel::Parameter do
    color    { nil }
    include  { nil }
    exclude  { nil }
    interval { nil }

    initialize_with do
      ::Model::Channel::Parameter.new(color: color, include: include, exclude: exclude, interval: interval)
    end
  end
end
