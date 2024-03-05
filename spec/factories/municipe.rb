FactoryBot.define do
  factory :municipe do
    full_name { Faker::Name.name }
    cpf { Faker::CPF.numeric }
    cns { "902046613580000" }
    email { Faker::Internet.email }
    birth { Faker::Date.birthday(min_age: 18, max_age: 65) }
    phone { Faker::PhoneNumber.phone_number }
    photo { Rack::Test::UploadedFile.new(Rails.root.join('spec/support/uploads/image_for_test.png'), 'image/png') }
    status { ["ativo", "inativo"].sample }
  end
end
