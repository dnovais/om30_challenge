FactoryBot.define do
  factory :municipe do
    full_name { Faker::Name.name }
    cpf { Faker::CPF.numeric }
    cns { "902046613580000" }
    email { Faker::Internet.email }
    birth { Faker::Date.birthday(min_age: 18, max_age: 65) }
    phone { Faker::PhoneNumber.phone_number }
    photo { Faker::Internet.url }
    status { ["ativo", "inativo"].sample }
  end
end
