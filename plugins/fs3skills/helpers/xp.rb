module AresMUSH
  module FS3Skills
    def self.can_manage_xp?(actor)
      actor.has_permission?("manage_abilities")
    end
    
    def self.modify_xp(char, amount)
      max_xp = Global.read_config("fs3skills", "max_xp_hoard")
      xp = char.xp + amount
      xp = [max_xp, xp].min
      char.update(fs3_xp: xp)
    end
    
    def self.days_between_learning
      Global.read_config("fs3skills", "days_between_learning")
    end
    
    def self.xp_needed(ability_name, rating)
      ability_type = FS3Skills.get_ability_type(ability_name)
      costs = Global.read_config("fs3skills", "xp_costs")
      costs = costs[ability_type.to_s]
      # Goofiness needed because XP keys could be either strings or integers.
      key = costs.keys.select { |r| r.to_s == rating.to_s }.first
      key ? costs[key] : nil
    end
    
    def self.check_can_learn(char, ability_name, rating)
      return t('fs3skills.cant_raise_further_with_xp') if self.xp_needed(ability_name, rating) == nil

      ability_type = FS3Skills.get_ability_type(ability_name)
      
      if (ability_type == :attribute)
        # Attrs cost 2 points per dot
        dots_beyond_chargen = Global.read_config("fs3skills", "attr_dots_beyond_chargen_max") || 2
        max = Global.read_config("fs3skills", "max_points_on_attrs") + (dots_beyond_chargen * 2)
        points = AbilityPointCounter.points_on_attrs(char)
        new_total = points + 2
      elsif (ability_type == :action)
        dots_beyond_chargen = Global.read_config("fs3skills", "action_dots_beyond_chargen_max") || 3
        max = Global.read_config("fs3skills", "max_points_on_action") + dots_beyond_chargen
        points = AbilityPointCounter.points_on_action(char)
        new_total = points + 1
      else
        return nil
      end
      
      return max >= new_total ? nil : t('fs3skills.max_ability_points_reached')
    end

    def self.skill_requires_training(ability)
      skills_requiring_training = Global.read_config("fs3skills", "skills_requiring_training")
      return (skills_requiring_training.include?(ability.name) && ability.rating <= 2)
    end
    
    def self.learn_ability(client, char, name)
      ability = FS3Skills.find_ability(char, name)
      
      ability_type = FS3Skills.get_ability_type(name)
      if (ability_type == :advantage && !Global.read_config("fs3skills", "allow_advantages_xp"))
        client.emit_failure t('fs3skills.cant_learn_advantages_xp')
        return
      end
      
      if (!ability)
        FS3Skills.set_ability(client, char, name, 1)
      else
        
        error = FS3Skills.check_can_learn(char, name, ability.rating)
        if (error)
          client.emit_failure error
          return
        end

        if (!ability.can_learn?)
          time_left = ability.time_to_next_learn / 86400
          client.emit_failure t('fs3skills.cant_raise_yet', :days => time_left.ceil)
          return
        end
        
        ability.learn
        if (ability.learning_complete)
          ability.update(xp: 0)
          FS3Skills.set_ability(client, char, name, ability.rating + 1)
          message = t('fs3skills.xp_raised_job', :name => char.name, :ability => name, :rating => ability.rating + 1)
          category = Jobs.system_category
          Jobs.create_job(category, t('fs3skills.xp_job_title', :name => char.name), message, Game.master.system_character)
        else
          client.emit_success t('fs3skills.xp_spent', :name => name)
        end
        
        if (FS3Skills.skill_requires_training(ability))
          client.emit_ooc t('fs3skills.skill_requires_training', :name => name)
        end
      end 
      
      
      FS3Skills.modify_xp(char, -1)       
    end
  end
end