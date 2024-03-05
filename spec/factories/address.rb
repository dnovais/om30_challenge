FactoryBot.define do
  factory :address do
    association :municipe
    street { Faker::Address.street_name }
    complement { Faker::Address.secondary_address }
    neighborhood { Faker::Address.community }
    city { Faker::Address.city }
    uf { Faker::Address.state_abbr }
    ibge_code { Faker::Number.number(digits: 7) }
  end
end
