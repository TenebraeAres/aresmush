module AresMUSH
	module RPTokens
		class RPTMoveCmd
			include CommandHandler
			attr_accessor :transferor, :transferee, :number, :error
			
			def check_approved
				return nil if enactor.is_approved? || enactor.is_admin?
				return t('dispatcher.not_allowed')
			end
			
			def parse_args	
				args = cmd.parse_args(Custom.arg1_booltofrom_arg2)
				if args.bool = "to "
					self.transferor = enactor.name
					self.transferee = args.arg2
				else
					self.transferee = enactor.name
					self.transferor = args.arg2
				end
				self.number = integer_arg(args.arg1)
			end
			
			def required_args
                [self.transferor, self.transferee, self.number]
            end
			
            def check_tokens
                return "Bad tokens" if self.number < 1
                return nil
            end
			
			def handle
				self.transferor = Character.find_one_by_name(self.transferor)
				self.transferee = Character.find_one_by_name(self.transferee)
				
				self.error = RPTokens.check_move(self.transferor, self.transferee, self.number)
				
				if self.error.blank?
					client.emit_success RPTokens.move_tokens(self.transferor, self.transferee, self.enactor, self.number)
				else
					client.emit_failure self.error
				end
				
			end
		end
	end
end