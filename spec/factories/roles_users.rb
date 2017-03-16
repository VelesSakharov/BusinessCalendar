# frozen_string_literal: true
FactoryGirl.define do
  factory :roles_user do
    role_id { rand(29) }
    user_id { rand(29) }
  end
end
