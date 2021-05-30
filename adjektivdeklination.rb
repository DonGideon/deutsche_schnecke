require './telegram_response_creator'

class Adjektivdeklination
    @@prints = {
        :bestimmte_adjektive => {
            :nominativ => "
                **NOM**
                m - der gute Freund
                n - das gute Projekt
                f - die gute Freundin
                pl - die guten Freunde
            ",
            :akkusativ => "
                **AKK**
                m - den guten Freund
                n - das gute Projekt
                f - die gute Freundin
                pl - die guten Freunde
            ",
            :dativ => "
                **DAT**
                m - dem guten Freund
                n - dem guten Projekt
                f - der guten Freundin
                pl - den guten Freunden
            ",
        },
        :unbestimmte_adjektive => {
            :nominativ => "
                **NOM**
                m - ein guter Freund
                n - ein gutes Projekt
                f - eine gute Freundin
                pl - gute Freunde**
            ",
            :akkusativ => "
                **AKK**
                m - einen guten Freund
                n - ein gutes Projekt
                f - eine gute Freundin
                pl - gute Freunde**
            ",
            :dativ => "
                **DAT**
                m - einem guten Freund
                n - einem guten Projekt
                f - einer guten Freundin
                pl - guten Freunden
            ",
        }
    }

    def self.MessageLogic(message, bot)
        telegramResponseCreator = TelegramResponseCreator.new(message, bot)
        case
            when message.data == 'adjektivdeklination'
                telegramResponseCreator.inlineKeyboardButtons(
                [
                    {:text => 'Bestimmte Adjektive (die...)', :callback_data => 'adjektivdeklination_bestimmte_adjektive'},
                    {:text => 'Unbestimmte Adjektive (ein...)', :callback_data => 'adjektivdeklination_unbestimmte_adjektive'}
                ],
                'Bestimmte Adjektive or Unbestimmte Adjektive?'
                )
            when message.data == 'adjektivdeklination_bestimmte_adjektive'
                telegramResponseCreator.inlineKeyboardButtons(
                [
                    {:text => 'Nominativ', :callback_data => 'adjektivdeklination_bestimmte_adjektive_nominativ'},
                    {:text => 'Akkusativ', :callback_data => 'adjektivdeklination_bestimmte_adjektive_akkusativ'},
                    {:text => 'Dativ', :callback_data => 'adjektivdeklination_bestimmte_adjektive_dativ'}
                ],
                'Akkusativ or Dativ?'
                )
            when message.data == 'adjektivdeklination_bestimmte_adjektive_nominativ'
                telegramResponseCreator.textResponse(@@prints[:bestimmte_adjektive][:nominativ])
            when message.data == 'adjektivdeklination_bestimmte_adjektive_akkusativ'
                telegramResponseCreator.textResponse(@@prints[:bestimmte_adjektive][:akkusativ])
            when message.data == 'adjektivdeklination_bestimmte_adjektive_dativ'
                telegramResponseCreator.textResponse(@@prints[:bestimmte_adjektive][:dativ])
            when message.data == 'adjektivdeklination_unbestimmte_adjektive'
                telegramResponseCreator.inlineKeyboardButtons(
                [
                    {:text => 'Nominativ', :callback_data => 'adjektivdeklination_unbestimmte_adjektive_nominativ'},
                    {:text => 'Akkusativ', :callback_data => 'adjektivdeklination_unbestimmte_adjektive_akkusativ'},
                    {:text => 'Dativ', :callback_data => 'adjektivdeklination_unbestimmte_adjektive_dativ'}
                ],
                'Akkusativ or Dativ?'
                )
            when message.data == 'adjektivdeklination_unbestimmte_adjektive_nominativ'
                telegramResponseCreator.textResponse(@@prints[:unbestimmte_adjektive][:nominativ])
            when message.data == 'adjektivdeklination_unbestimmte_adjektive_akkusativ'
                telegramResponseCreator.textResponse(@@prints[:unbestimmte_adjektive][:akkusativ])
            when message.data == 'adjektivdeklination_unbestimmte_adjektive_dativ'
                telegramResponseCreator.textResponse(@@prints[:unbestimmte_adjektive][:dativ])
        end
    end
end