# frozen_string_literal: true
class Worker
  include Sidekiq::Worker
  def perform(new_note)
  @note = Note.all
  # User.find_each(is_subscribed: true) do |user|
  #   Sidekiq.redis
  # end
  end
end
