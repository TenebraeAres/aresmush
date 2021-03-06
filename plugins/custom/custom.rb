$:.unshift File.dirname(__FILE__)

module AresMUSH
  module Custom
    def self.plugin_dir
      File.dirname(__FILE__)
    end
 
    def self.shortcuts
      Global.read_config("custom", "shortcuts")
    end
 
    def self.get_cmd_handler(client, cmd, enactor)
		case cmd.root
		when "sparkle"
			case cmd.switch
			when "set"
				return SetSparkleCmd
			else 
				return SparkleCmd
			end
		end
	  return nil
	end
	
	def self.get_cmd_handler(client, cmd, enactor)
	  case cmd.root
	  when "guac"
		case cmd.switch
		when "set"
		  return SetGuacCmd
		else
		  return GuacCmd
		end
	  end
	  return nil
	end
	
	
  end
end