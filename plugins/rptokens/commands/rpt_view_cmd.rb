module AresMUSH
	module RPTokens
		class RPTViewCmd
			include CommandHandler
			attr_accessor :char, :error
			
			def parse_args
				if (!cmd.args)
					self.char = enactor
				else
					self.char = cmd.args
				end
			end
			
			def handle
				self.char = Character.find_one_by_name(self.char)
				
				self.error = Custom.alt_check(enactor, self.char)
				
				if (!error)
					return error
				else
					template = RPTokensListTemplate.new self.char.name
					client.emit template.render
				end
			end
		end
	end
end