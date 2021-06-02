require 'telegram/bot'
require "./akkusativ_or_dativ"
require "./personalpronomen"
require "./possessivartikel"
require "./adjektivdeklination"
require 'dotenv/load'

token = ENV["TOKEN"]

Telegram::Bot::Client.run(token) do |bot|
    bot.listen do |message|
        logLine = "#{message.from.first_name} #{message.from.last_name} #{message.from.username} | message: "

        telegramResponseCreator = TelegramResponseCreator.new(message, bot)
        case
            when message.class == Telegram::Bot::Types::CallbackQuery
                logLine += message.data 
                case 
                    when message.data.include?("akkusativ_or_dativ")
                        AkkusativOrDativ.MessageLogic(telegramResponseCreator, message.data)
               
                    when message.data.include?("personalpronomen")
                        Personalpronomen.MessageLogic(telegramResponseCreator, message.data)
               
                    when message.data.include?("possessivartikel")
                        Possessivartikel.MessageLogic(telegramResponseCreator, message.data)
             
                    when message.data.include?("adjektivdeklination")
                        Adjektivdeklination.MessageLogic(telegramResponseCreator, message.data)
              
                    when message.data == "how_to_conjugate"
                        telegramResponseCreator.textResponse("Type 'C: ' and the Verb you want to Conjugate (exmp: 'C: Helfen')")
              
                    when message.data == "translate_and_gender"
                        telegramResponseCreator.textResponse("Type 'T: ' and the Word you want to Translate or find its Gender (exmp: 'T: Schnecke')")
                end
            when message.class == Telegram::Bot::Types::Message
                theWord = message.text.downcase.delete(' ').delete('/')
                logLine += theWord
                case
                    when theWord == 'h' || theWord == 'hilfe' || theWord == 'help' || theWord == 'start'
                        kb = [
                            Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Noun is Akkusativ or Dativ?', callback_data: 'akkusativ_or_dativ'),
                            Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Personalpronomen (mir / mich...)', callback_data: 'personalpronomen'),
                            Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Possessivartikel (mein...)', callback_data: 'possessivartikel'),
                            Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Adjektivdeklination', callback_data: 'adjektivdeklination'),
                            Telegram::Bot::Types::InlineKeyboardButton.new(text: 'How Do I conjugate...', callback_data: 'how_to_conjugate'),
                            Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Translate and Gender of...', callback_data: 'translate_and_gender')
                        ]
                        markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: kb)
                        bot.api.send_message(chat_id: message.chat.id, text: '🐌 WÄHLE!', reply_markup: markup)
                    when theWord.include?('c:')
                        conjugateVerb = message.text.split().last
                        telegramResponseCreator.linkResponse("https://conjugator.reverso.net/conjugation-german-verb-SEARCHWORD.html", conjugateVerb, "Conjugate")
                    when theWord.include?('t:')
                        translateWord = message.text.split().last
                        telegramResponseCreator.linkResponse("https://www.dict.cc/?s=SEARCHWORD", translateWord, "Translate")
                    when theWord == ('🐌')
                        telegramResponseCreator.textResponse('❤️')
                end
        end
        File.write("log#{Time.now.month}.txt", "#{Time.now} | #{logLine}\n", mode: "a")
    end
end