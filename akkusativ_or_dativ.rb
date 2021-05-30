require './telegram_response_creator'

class AkkusativOrDativ
  @@prints = {
    :prapositionen => {
      :akkusativ => "
          **AKK**\n
          - bis (till)\n
          - gegen (against, towards)\n
          - um (location: around / time: at)\n
          - durch (through)\n
          - ohne (without)\n
          - entlang (along)
      ",
      :dativ => "
          **DAT**\n
          - aus (from originally)\n
          - von (from, of)\n
          - zu (to)\n
          - nach (to - streets, cities, countries, after)\n
          - vor (before, ago)\n
          - mit (with)\n
          - seit (since)\n
          - bei (at - name of people/companies, during/while)\n
          - Gegenüber* (in front of (will come after the noun))\n
      ",
    },
    :fragen => {
        :akkusativ => "
            **AKK**\n
            - Wohin? Where to (with action)
            - Was? what
            - Wen? who
        ",
        :dativ => "
            **DAT**\n
            - Wo? where
            - Wann? when
            - Wem? whom
        ",
    }
  }

    def self.MessageLogic(message, bot)
        telegramResponseCreator = TelegramResponseCreator.new(message, bot)
        case
            when message.data == 'akkusativ_or_dativ'
                telegramResponseCreator.inlineKeyboardButtons(
                [
                    {:text => 'Präpositionen', :callback_data => 'akkusativ_or_dativ_prapositionen'},
                    {:text => 'Fragen', :callback_data => 'akkusativ_or_dativ_fragen'}
                ],
                'Präpositionen or Fragen?'
                )
            when message.data == 'akkusativ_or_dativ_prapositionen'
                telegramResponseCreator.inlineKeyboardButtons(
                [
                    {:text => 'Akkusativ', :callback_data => 'akkusativ_or_dativ_prapositionen_akkusativ'},
                    {:text => 'Dativ', :callback_data => 'akkusativ_or_dativ_prapositionen_dativ'}
                ],
                'Akkusativ or Dativ?'
                )
            when message.data == 'akkusativ_or_dativ_prapositionen_akkusativ'
                telegramResponseCreator.textResponse(@@prints[:prapositionen][:akkusativ])
            when message.data == 'akkusativ_or_dativ_prapositionen_dativ'
                telegramResponseCreator.textResponse(@@prints[:prapositionen][:dativ])
            when message.data == 'akkusativ_or_dativ_fragen'
                telegramResponseCreator.inlineKeyboardButtons(
                [
                    {:text => 'Akkusativ', :callback_data => 'akkusativ_or_dativ_fragen_akkusativ'},
                    {:text => 'Dativ', :callback_data => 'akkusativ_or_dativ_fragen_dativ'}
                ],
                'Akkusativ or Dativ?'
                )
            when message.data == 'akkusativ_or_dativ_fragen_akkusativ'
                telegramResponseCreator.textResponse(@@prints[:fragen][:akkusativ])
            when message.data == 'akkusativ_or_dativ_fragen_dativ'
                telegramResponseCreator.textResponse(@@prints[:fragen][:dativ])
        end
    end
end