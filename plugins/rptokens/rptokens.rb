module AresMUSH
	module RPTokens	
		def check_approved
			return nil if enactor.is_approved? || enactor.is_admin?
			return t('dispatcher.not_allowed')
		end
		def self.plugin_dir
			File.dirname(__FILE__)
		end
		def self.get_cmd_handler(client, cmd, enactor)
			case cmd.root
			when "rpt"
				case cmd.switch
				when "add"
					return RPTModifyCmd
				when "remove"
					return RPTModifyCmd
				when "approve"
					return RPTApproveCmd
				when "spend"
					return RPTSpendCmd
				when "request"
					return RPTSubmitCmd
				when "move"
					return RPTMoveCmd
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