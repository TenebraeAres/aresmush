module AresMUSH
	module RPTokens
		class RPTViewCmd
			include CommandHandler
			attr_accessor :name
			
			def parse_args
				if (!cmd.args)
					self.name = enactor.name
				else
					self.name = cmd.args
				end
			end
			
			def handle
				char = Character.find_one_by_name(self.name)
				
				error = Custom.alt_check(enactor, char)
				
				if cmd.switch == "all"
					ct = char.rpt_log.size
				else
					ct = 5
				end
				
				if (!error)
					template = RPTokensListTemplate.new char, ct
					client.emit template.render
				else
					client.emit_failure error
				end
			end
		end
	end
end