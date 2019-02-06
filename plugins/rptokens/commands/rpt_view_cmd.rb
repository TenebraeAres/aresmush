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
				
				if (!error)
					return error
				else
					template = RPTokensListTemplate.new self.name
					client.emit template.render
				end
			end
		end
	end
end