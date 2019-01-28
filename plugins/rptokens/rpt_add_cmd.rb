module AresMUSH
	module RPTokens
		class RPTAddCmd
			include CommandHandler
			attr_accessor :name, :number, :reason
			def parse_args	
				args = cmd.parse_args(ArgParser.arg1_equals_arg2_slash_arg3)
				self.name = args.arg1
				self.number = integer_arg(args.arg2)
				self.reason = args.arg3
			end

			def required_args
				[self.name, self.number, self.reason]
			end

			def handle
				 client.emit_success "RP Tokens: #{self.name} #{self.number} #{self.reason}" 
			end
		end
	end
end