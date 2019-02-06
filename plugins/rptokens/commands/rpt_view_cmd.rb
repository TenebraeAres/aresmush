module AresMUSH
	module RPTokens
		class RPTViewCmd
			include CommandHandler
			attr_accessor :name, :error
			
			def parse_args
				if (!cmd.args)
					self.name = enactor.name
				else
					self.name = cmd.args
				end
			end
			
			def handle
				self.name = Character.find_one_by_name(self.name)
				
				self.error = Custom.alt_check(enactor, self.name)
				
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