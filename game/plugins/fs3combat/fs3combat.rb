$:.unshift File.dirname(__FILE__)
load "fs3combat_api.rb"

# Models must come first
load "lib/models/combat_action.rb"
load "lib/models/combat_instance.rb"
load "lib/models/combat_model.rb"
load "lib/models/combatant.rb"
load "lib/models/damage.rb"
load "lib/models/vehicle.rb"

load "lib/actions/action_checkers.rb"
load "lib/actions/aim_action.rb"
load "lib/actions/attack_action.rb"
load "lib/actions/fullauto_action.rb"
load "lib/actions/pass_action.rb"
load "lib/actions/reload_action.rb"
load "lib/actions/treat_action.rb"
load "lib/common_checks.rb"
load "lib/damage/damage_cmd.rb"
load "lib/damage/damage_cron_handler.rb"
load "lib/damage/inflict_damage_cmd.rb"
load "lib/damage/treat_cmd.rb"
load "lib/gear/armor_detail_cmd.rb"
load "lib/gear/armor_list_cmd.rb"
load "lib/gear/combat_armor_cmd.rb"
load "lib/gear/combat_hitlocs_cmd.rb"
load "lib/gear/combat_weapon_cmd.rb"
load "lib/gear/vehicle_detail_cmd.rb"
load "lib/gear/vehicles_list_cmd.rb"
load "lib/gear/weapon_detail_cmd.rb"
load "lib/gear/weapons_list_cmd.rb"
load "lib/general/combat_action_cmd.rb"
load "lib/general/combat_ai_cmd.rb"
load "lib/general/combat_disembark_cmd.rb"
load "lib/general/combat_join_cmd.rb"
load "lib/general/combat_leave_cmd.rb"
load "lib/general/combat_list_cmd.rb"
load "lib/general/combat_luck_cmd.rb"
load "lib/general/combat_newturn_cmd.rb"
load "lib/general/combat_stance_cmd.rb"
load "lib/general/combat_start_cmd.rb"
load "lib/general/combat_stop_cmd.rb"
load "lib/general/combat_team_cmd.rb"
load "lib/general/combat_types_cmd.rb"
load "lib/general/combat_vehicle_cmd.rb"
load "lib/helpers/actions.rb"
load "lib/helpers/damage.rb"
load "lib/helpers/gear.rb"
load "lib/helpers/general.rb"
load "lib/status/combat_hud_cmd.rb"
load "lib/status/combat_npcskill_cmd.rb"
load "lib/status/combat_summary_cmd.rb"
load "templates/damage_template.rb"
load "templates/gear_template.rb"
load "templates/hud_template.rb"
load "templates/summary_template.rb"

module AresMUSH
  module FS3Combat
    def self.plugin_dir
      File.dirname(__FILE__)
    end
 
    def self.shortcuts
      Global.read_config("fs3combat", "shortcuts")
    end
 
    def self.load_plugin
      self
    end
 
    def self.unload_plugin
    end
 
    def self.help_files
      [ "help/actions.md", "help/combat.md", "help/damage.md", "help/gear.md", "help/luck.md", "help/org.md" ]
    end
 
    def self.config_files
      [ "config_fs3combat.yml", "config_fs3combat_armor.yml", "config_fs3combat_damage.yml", "config_fs3combat_hitloc.yml", "config_fs3combat_vehicles.yml", "config_fs3combat_weapons.yml" ]
    end
 
    def self.locale_files
      [ "locales/locale_en.yml" ]
    end
 
    def self.get_cmd_handler(client, cmd)
      case cmd.root
      when"damage"
         case cmd.switch
         when "inflict"
           return InflictDamageCmd
         when nil
           return DamageCmd
         end
       when "treat"
         return TreatCmd
       when "armor"
         if (cmd.args)
           return ArmorDetailCmd
         else
           return ArmorListCmd
         end
       when "vehicle"
         if (cmd.args)
           return VehicleDetailCmd
         else
           return VehiclesListCmd
         end
       when "weapon"
         if (cmd.args)
           return WeaponDetailCmd
         else
           return WeaponsListCmd
         end
       when "combats"
         return CombatListCmd
       when "combat"
         case cmd.switch
         when "armor"
           return CombatArmorCmd
         when "hitlocs"
           return CombatHitlocsCmd
         when "weapon"
           return CombatWeaponCmd
         when "ai"
           return CombatAiCmd
         when "disembark"
           return CombatDisembarkCmd
         when "join"
           return CombatJoinCmd
         when "leave"
           return CombatLeaveCmd
         when "luck"
           return CombatLuckCmd
         when "newturn"
           return CombatNewTurnCmd
         when "skill"
           return CombatNpcSkillCmd
         when "stance"
           return CombatStanceCmd
         when "start"
           return CombatStartCmd
         when "stop"
           return CombatStopCmd
         when "summary"
           return CombatSummaryCmd
         when "team"
           return CombatTeamCmd
         when "types"
           return CombatTypesCmd
         when "pilot", "passenger"
           return CombatVehicleCmd
         when nil
           return CombatHudCmd
         else
           return CombatActionCmd
         end
       end
       
       nil
    end

    def self.get_event_handler(event_name) 
    end
  end
end