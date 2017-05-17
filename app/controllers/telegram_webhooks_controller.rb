class TelegramWebhooksController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::MessageContext
  context_to_action!

  # def initialize(user_id)
  #   SendNotes.perform_async
  #   notificate_user(user_id)
  # end

  def start(*args)
    keyboard
    respond_with :message, text: "Please enter that value in User edit page: #{from['id']}"
    users = User.all
    @user_id = users.where(telegram_id: update['message']['from']['id']).ids
    notes = Note.where(user_id: @user_id)
    notes.each do |note|
      if (Time.now < note.appointment.to_datetime)
        left = (Time.now - note.appointment.to_datetime).abs.round
        pp left
        sleep(left)
        pp "111111111111111111111"
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
    #notificate_user(203145186)
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
    redis = Redis.new
    redis.set("#{@user_id}", )
    redis.set('foo1', 'bar1')
    pp redis.get(@user_id)
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

  # def inline_keyboard
  #   respond_with :message, text: 'Check my inline keyboard:', reply_markup: {
  #       inline_keyboard: [
  #           [
  #               {text: 'Answer with alert', callback_data: 'alert'},
  #               {text: 'Without alert', callback_data: 'no_alert'},
  #           ],
  #       ],
  #   }
  # end

  # def callback_query(data)
  #   if data == 'alert'
  #     answer_callback_query 'This is ALERT-T-T!!!', show_alert: true
  #   else
  #     answer_callback_query 'Simple answer'
  #   end
  # end

  def message(message)
    respond_with :message, text: "Сам ты - #{message['text']}"
  end


  # def inline_query(query, offset)
  #   query = query.first(10) # it's just an example, don't use large queries.
  #   results = 5.times.map do |i|
  #     {
  #         type: :article,
  #         title: "#{query}-#{i}",
  #         id: "#{query}-#{i}",
  #         description: "description #{i}",
  #         input_message_content: {
  #             message_text: "content #{i}",
  #         },
  #     }
  #   end
  #   answer_inline_query results
  # end

  # There are no such requests from telegram :(
  # If you know, how can this be performed, open an issue pls.
  # def chosen_inline_result(result_id, query)
  #   respond_with :message, "Query: #{query}\nYou've chosen: #{result_id}"
  # end
  #
  # def action_missing(action, *_args)
  #   respond_with :message, text: "Can not perform #{action}" if command?
  # end

  private

  # def update_params
  #   permit()
  # end

  def fetch_update_params
    a =
        update["update_id"],
            update["message"]["message_id"],
            update["message"]["from"],
            update["message"]["chat"],
            update["message"]["date"],
            update["message"]["text"],
            update["message"]["entities"]

    # a = update.fetch("update_id").to_i,
    #     update.fetch("message").fetch("message_id").to_i,
    #     update.fetch("message").fetch("from").to_json,
    #     update.fetch("message").fetch("chat").to_json,
    #     update.fetch("message").fetch("date").to_i,
    #     update.fetch("message").fetch("text").to_s,
    #     update.fetch("message").fetch("entities").to_a
  end
  def perform
  end

end
