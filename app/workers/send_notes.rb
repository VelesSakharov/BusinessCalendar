# frozen_string_literal: true
class SendNotes < Telegram::Bot::UpdatesController
  include Sidekiq::Worker
  include Telegram::Bot::UpdatesController::MessageContext
  def perform
    pp 1123123123123 if Telegram::Bot::UpdatesPoller.start(ENV['BOT'].try!(:to_sym) || :default)
  end
end
