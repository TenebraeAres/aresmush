module AresMUSH
  module FS3Combat
    class CombatHeroCmd
      include CommandHandler
      include CommandRequiresLogin
      include CommandRequiresArgs
      include NotAllowedWhileTurnInProgress
      
      
      def check_points
        return t('fs3combat.no_luck') if enactor.luck <= 1
        return nil
      end
    
      
      def handle
        FS3Combat.with_a_combatant(enactor_name, client, enactor) do |combat, combatant|
          if (!combatant.is_ko)
            client.emit_failure t('fs3combat.not_koed')
            return
          end
          
          enactor.spend_luck(1)
          combatant.update(is_ko: false)
          
          combat.emit t('fs3combat.back_in_the_fight', :name => enactor_name)
        end
      end
    end
  end
end