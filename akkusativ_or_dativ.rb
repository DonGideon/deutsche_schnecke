require './telegram_response_creator'

class AkkusativOrDativ
    @@prints = {
        :prapositionen => {
            :akkusativ => "
                **AKK**
                - bis (till)
                - gegen (against, towards)
                - um (location: around / time: at)
                - durch (through)
                - ohne (without)
                - entlang (along)
            ",
            :dativ => "
                **DAT**
                - aus (from originally)
                - von (from, of)
                - zu (to)
                - nach (to - streets, cities, countries, after)
                - vor (before, ago)
                - mit (with)
                - seit (since)
                - bei (at - name of people/companies, during/while)
                - Gegenüber* (in front of (will come after the noun))
            ",
        },
        :fragen => {
            :akkusativ => "
                **AKK**
                - Wohin? Where to (with action)
                - Was? what
                - Wen? who
            ",
            :dativ => "
                **DAT**
                - Wo? where
                - Wann? when
                - Wem? whom
            ",
        }
    }

    def self.MessageLogic(telegramResponseCreator, messageData)
        case
            when messageData == 'akkusativ_or_dativ'
                telegramResponseCreator.inlineKeyboardButtons(
                [
                    {:text => 'Präpositionen', :callback_data => 'akkusativ_or_dativ_prapositionen'},
                    {:text => 'Fragen', :callback_data => 'akkusativ_or_dativ_fragen'}
                ],
                'Präpositionen or Fragen?'
                )
            when messageData == 'akkusativ_or_dativ_prapositionen'
                telegramResponseCreator.inlineKeyboardButtons(
                [
                    {:text => 'Akkusativ', :callback_data => 'akkusativ_or_dativ_prapositionen_akkusativ'},
                    {:text => 'Dativ', :callback_data => 'akkusativ_or_dativ_prapositionen_dativ'}
                ],
                'Akkusativ or Dativ?'
                )
            when messageData == 'akkusativ_or_dativ_prapositionen_akkusativ'
                telegramResponseCreator.textResponse(@@prints[:prapositionen][:akkusativ])
            when messageData == 'akkusativ_or_dativ_prapositionen_dativ'
                telegramResponseCreator.textResponse(@@prints[:prapositionen][:dativ])
            when messageData == 'akkusativ_or_dativ_fragen'
                telegramResponseCreator.inlineKeyboardButtons(
                [
                    {:text => 'Akkusativ', :callback_data => 'akkusativ_or_dativ_fragen_akkusativ'},
                    {:text => 'Dativ', :callback_data => 'akkusativ_or_dativ_fragen_dativ'}
                ],
                'Akkusativ or Dativ?'
                )
            when messageData == 'akkusativ_or_dativ_fragen_akkusativ'
                telegramResponseCreator.textResponse(@@prints[:fragen][:akkusativ])
            when messageData == 'akkusativ_or_dativ_fragen_dativ'
                telegramResponseCreator.textResponse(@@prints[:fragen][:dativ])
        end
    end
end