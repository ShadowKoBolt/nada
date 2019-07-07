# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name  { Faker::Name.last_name }
    email { Faker::Internet.email }
    password { 'password' }
    admin { false }
    address_line_1 { Faker::Address.street_address }
    address_line_2 { [Faker::Address.secondary_address, nil].sample }
    address_line_3 { [Faker::Address.secondary_address, nil].sample }
    city { Faker::Address.city }
    region { Faker::Address.state }
    postcode { Faker::Address.zip_code }
    country { Faker::Address.country_code }
    renewal_date { 1.year.from_now }
  end
end
