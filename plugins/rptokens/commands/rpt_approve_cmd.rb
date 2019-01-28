module AresMUSH
	module RPTokens
		class RPTApproveCmd
			include CommandHandler
			attr_accessor :number, :reason
			
			def check_approved
				return nil if enactor.is_admin?
				return t('dispatcher.not_allowed')
			end
			
			def parse_args	
				args = cmd.parse_args(ArgParser.arg1_equals_arg2)
				self.number = integer_arg(args.arg1)
				self.reason = args.arg2
			end

			def required_args
				[self.number, self.reason]
			end

			def handle
				client.emit_success "RP Tokens: #{self.name} #{self.number} #{self.reason}" 
			end
		end
	end
end