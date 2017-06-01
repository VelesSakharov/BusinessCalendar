class TelegramWebhooksController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::MessageContext
  context_to_action!

  def start(*args)
    keyboard
    respond_with :message, text: "Please enter that value in User edit page: #{from['id']}"
    users = User.all
    @user_id = users.where(telegram_id: update['message']['from']['id']).ids
    notes = Note.where(user_id: @user_id)
    notes.each do |note|
      if (Time.now < note.appointment.to_datetime)
        left = (Time.now - note.appointment.to_datetime).abs.round
        sleep(left)
      end
    end
  end

  def all(*args)
    respond_with :message, text: <<-TXT.strip_heredoc
      Available cmds:
      /start - Restarts chat with server(only for updates)
      /keyboard - Opens keyboard with shortcuts
      /memo %text% - Saves text to session.
      /remind - Replies with text from session.
    TXT
  end

  def memo(*args)

    if args.any?
      session[:memo] = args
      respond_with :message, text:  "Memo'd #{args}"
    else
      respond_with :message, text: 'What should I remember?'
      save_context :memo
    end
  end

  def remind
    @replies = TelegramService.new.get_new_notes
    @replies.each do |reply|
      respond_with :message, text: "#{reply[:title]}: #{reply[:content]}! Appointment: #{reply[:appointment]}"
    end
  end

  def keyboard(value = nil, *)
    if value
      respond_with :message, text: "You've selected: #{value}"
    else
      save_context :keyboard
      respond_with :message, text: "Now You're using keyboard", reply_markup: {
          keyboard:[ %W(/all /keyboard /remind)
          ],
          resize_keyboard: true,
          one_time_keyboard: false,
          selective: true
      }
    end
  end

  def notificate_user(telegram_user_id)
    @replies = TelegramService.new.get_notes
    @replies.each do |reply|
      bot.send_message(text: "Title: #{reply[:title]}; Content: #{reply[:content]}; Appointment: #{reply[:appointment]}",
                     chat_id: telegram_user_id)
    end
  end

  def message(message)
    respond_with :message, text: "Сам ты - #{message['text']}"
  end

  private

  def fetch_update_params
    a =
        update["update_id"],
            update["message"]["message_id"],
            update["message"]["from"],
            update["message"]["chat"],
            update["message"]["date"],
            update["message"]["text"],
            update["message"]["entities"]
  end

  def perform
  end

end
