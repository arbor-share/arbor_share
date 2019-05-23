FactoryBot.define do
  factory :user_address do
    user
    line_1 { Faker::Address.street_name }
    city { Faker::Address.city }
    state { Faker::Address.state_abbr }
    zip { Faker::Address.zip_code }
    default { true }
  end

  factory :project_address do
    project
    line_1 { Faker::Address.street_name }
    city { Faker::Address.city }
    state { Faker::Address.state_abbr }
    zip { Faker::Address.zip_code }
    default { true }
  end
end
