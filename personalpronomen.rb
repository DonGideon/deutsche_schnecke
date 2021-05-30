require './telegram_response_creator'

class Personalpronomen
  @@prints = "
    *NOM* - *AKK* - *DAT*
    ich - mich - mir
    du - dich - dir
    er - ihn - ihm
    es - es - ihm
    sie - sie - ihr
    ihr - euch - euch
    wir - uns - uns
    sie/Sie - sie/Sie - ihnen/Ihnen
  "

    def self.MessageLogic(telegramResponseCreator)
        if message.data == 'personalpronomen'
            telegramResponseCreator.textResponse(@@prints)
        end
    end
end