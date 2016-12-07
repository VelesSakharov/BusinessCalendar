require 'faker'


FactoryGirl.define do
  factory :role do
    name {Faker::App.name}
    description {Faker::Hacker.say_something_smart}

  end
end
