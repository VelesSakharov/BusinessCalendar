# frozen_string_literal: true
require 'faker'

FactoryGirl.define do
  factory :note do
    title { Faker::Book.title }
    content { Faker::Hacker.say_something_smart }
    appointment { Faker::Time.forward(10, :all) }
    user_id { rand(29) }
  end
end
