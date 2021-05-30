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

    def self.MessageLogic(telegramResponseCreator, messageData)
        if messageData == 'possessivartikel'
            telegramResponseCreator.textResponse(@@prints)
        end
    end
end