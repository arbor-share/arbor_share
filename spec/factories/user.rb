FactoryBot.define do
  factory :user do
    full_name { Faker::Games::Fallout.character }
    email { Faker::Internet.email }
    about { Faker::HitchhikersGuideToTheGalaxy.marvin_quote }
    avatar_image { 'https://image.shutterstock.com/image-vector/winter-couple-avatar-450w-1032649198.jpg' }
    google_token { rand(10000..999999999).to_s }
    google_id { rand(0.0000000001..1) }
    role { 0 }
    active { true }
  end

  factory :organizer, parent: :user do
    role { 1 }
  end

  factory :admin_user, parent: :user do
    role { 2 }
  end

  factory :deactivated_user, parent: :user do
    active { false }
  end
end
