require 'telegram/bot'
require "./akkusativ_or_dativ"
require "./personalpronomen"

token = '1894784635:AAGKmpYsvBSK9Pv0K7YjREDaVF-coVS922w'

Telegram::Bot::Client.run(token) do |bot|
    bot.listen do |message|
        case
            when message.class == Telegram::Bot::Types::CallbackQuery
                case 
                    when message.data.include?("akkusativ_or_dativ")
                        AkkusativOrDativ.MessageLogic(message, bot)
                end
                case 
                    when message.data.include?("personalpronomen")
                        Personalpronomen.MessageLogic(message, bot)
                end
            when message.class == Telegram::Bot::Types::Message && message.text.downcase.delete(' ') == 'hilfe'
                kb = [
                    Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Noun is Akkusativ or Dativ?', callback_data: 'akkusativ_or_dativ'),
                    Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Personalpronomen', callback_data: 'personalpronomen'),
                    Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Switch to inline', switch_inline_query: 'some text')
                ]
                markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: kb)
                bot.api.send_message(chat_id: message.chat.id, text: 'What do you want to know?', reply_markup: markup)
        end
    end
end