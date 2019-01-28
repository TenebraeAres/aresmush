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
				return RPTModifyCmd
			when "sub"
				return RPTModifyCmd
			when "app"
				return RPTApproveCmd
			when "spend"
				return RPTSpendCmd
			else
				return RPTSubmitCmd
			end
		end
		return nil
	end
  end
end