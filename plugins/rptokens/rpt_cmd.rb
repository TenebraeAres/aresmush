module AresMUSH
	module RPTokens
		class RPTCmd
			include CommandHandler
			def parse_args	
				args = self.parse_args(ArgParser.arg1_equals_arg2)
				if arg2.any?					
				else
					client.emit_fail "RPTokens Failure!"
					return nil
				end
			end
			
			def handle
				client.emit_success "RPTokens Accessed!"
			end
		end
	end
end