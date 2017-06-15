# frozen_string_literal: true
class SendNotes < TelegramWebhooksController
  include Sidekiq::Worker
  include Telegram::Bot::UpdatesController::MessageContext

  def perform
    @users = User.all
    @users.each do |user|
      if user.telegram_id.present?
        @notes = Note.where(user_id: user.id)
        @notes.each do |reply|
          system ("telegram-notify --user #{user.telegram_id} --key #{ENV['TELEGRAM_BOT_API_TOKEN']} --text 'Title: #{reply[:title]}; Content: #{reply[:content]}; Appointment: #{reply[:appointment]}'") if ( (reply.appointment - DateTime.now.in_time_zone).round < 3600 && (reply.appointment - DateTime.now.in_time_zone).round > 0 )
        end
      end
    end
  end
end
