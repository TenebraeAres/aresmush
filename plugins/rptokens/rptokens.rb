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
				when "approve"
					return RPTApproveCmd
				when "deny"
					return RPTDenyCmd
				when "move"
					return RPTMoveCmd
				when "remove"
					return RPTModifyCmd
				when "request"
					return RPTSubmitCmd
				when "spend"
					return RPTSpendCmd
				when "transfer"
					return RPTTransferCmd
				else
					return RPTViewCmd
				end
			end
			return nil
		end
	end
end