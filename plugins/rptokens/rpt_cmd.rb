module AresMUSH
	module RPTokens
		class RPTCmd
			include CommandHandler
			attr_accessor :title, :desc
			def parse_args	
				args = cmd.parse_args(ArgParser.arg1_equals_arg2)
				self.title = args.arg1
				self.desc = args.arg2
			end

			def required_args
				[self.title, self.desc]
			end

			def handle
				client.emit_success "RP Tokens: #{self.title} #{self.desc}"
			end
		end
	end
end