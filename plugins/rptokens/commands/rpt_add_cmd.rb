module AresMUSH
	module RPTokens
		class RPTAddCmd
			include CommandHandler
			attr_accessor :name, :number, :reason
			
			def check_approved
				return nil if enactor.is_admin?
				return t('dispatcher.not_allowed')
			end
			
			def parse_args	
				args = cmd.parse_args(ArgParser.arg1_equals_arg2_slash_arg3)
				self.name = args.arg1
				self.number = integer_arg(args.arg2)
				self.reason = args.arg3
			end
			
			def check_tokens
				return "Bad tokens" if self.number < 1
				return nil
			end

			def required_args
				[self.name, self.number, self.reason]
			end

			def handle
				ClassTargetFinder.with_a_character(self.name, client, enactor) do |model|
					client.emit_success "RP Tokens: #{model.name} #{self.number} #{self.reason}"
					model.update(rpt: model.rpt + self.number)
				end
			end
		end
	end
end