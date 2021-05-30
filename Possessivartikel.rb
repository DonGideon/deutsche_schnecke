require './telegram_response_creator'

class Possessivartikel
  @@prints = "
    *ENG* - *DEU*
    my - mein+
    your - dein+
    his - sein+
    her - ihr+
    its - sein+ 
    our - unser+
    your (plural) - euer/eure+
    their - ihr+
    your (formal) - Ihr+ 
  "

    def self.MessageLogic(message, bot)
        telegramResponseCreator = TelegramResponseCreator.new(message, bot)
        if message.data == 'possessivartikel'
            telegramResponseCreator.textResponse(@@prints)
        end
    end
end