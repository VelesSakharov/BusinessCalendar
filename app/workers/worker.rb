# frozen_string_literal: true
class Worker
  include Sidekiq::Worker
  def perform
    User.find_each(is_subscribed: true) do |user|
    end
  end
end
