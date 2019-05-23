FactoryBot.define do
  factory :project do
    title { Faker::Games::Fallout.location }
    date { Faker::Date.forward(5) }
    description { Faker::Hacker.say_something_smart }
    active { true }
    image { 'https://static.turbosquid.com/Preview/2017/01/21__14_22_51/TS_GW_GenericTree_preview_00.jpgB3196B6E-3F24-42B9-85A4-9183AD2B6006Original.jpg' }
    admin_user
  end

  factory :inactive_project, parent: :project do
    active { false }
  end

  factory :expired_project, parent: :project do
    active { false }
    date { Faker::Date.backward(5) }
  end
end
