class TelegramResponseCreator

    def initialize(message, bot)
        @message = message
        @bot = bot
    end

    def inlineKeyboardButtons(buttons, header)
        inline_keyboard_buttons = buttons.map do |button|
            Telegram::Bot::Types::InlineKeyboardButton.new(text: button[:text], callback_data: button[:callback_data])
        end

        markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: inline_keyboard_buttons)
        @bot.api.send_message(chat_id: @message.from.id, text: header, reply_markup: markup)
    end

    def textResponse(text)
        @bot.api.send_message(chat_id: @message.from.id, text: text)
    end
end