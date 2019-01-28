module AresMUSH
  module RPTokens
    def self.plugin_dir
		File.dirname(__FILE__)
    end
	def self.get_cmd_handler(client, cmd, enactor)
		case cmd.root
		when "rpt"
			case cmd.switch
			when "add"
				return RPTAddCmd(0)
			when "spend" || "sub"
				return RPTAddCmd(1)
			when "app"
				return RPTApproveCmd
			else
				return RPTCmd
			end
		end
		return nil
	end
  end
end