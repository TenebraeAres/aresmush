module AresMUSH
	module RPTokens
		class RPTTransferCmd
			include CommandHandler
			attr_accessor :transferer, :transferee, :number, :error
			
			def check_approved
				return nil if enactor.is_approved? || enactor.is_admin?
				return t('dispatcher.not_allowed')
			end
			
			def parse_args	
				args = cmd.parse_args(Custom.arg1_booltofrom_arg2)
				if args.bool = "to"
					self.transferer = enactor.name
					self.transferee = args.arg2
				else
					self.transferee = enactor.name
					self.transferer = args.arg2
				end
				self.number = integer_arg(args.arg1)
			end
			
			def required_args
                [self.transferer, self.transferee, self.number]
            end
			
            def check_tokens
                return "Bad tokens" if self.number < 1
                return nil
            end
			
			def handle
				self.transferer = Character.find_one_by_name(self.transferer)
				self.transferee = Character.find_one_by_name(self.transferee)
				
				self.error = RPTokens.check_move(self.transferer, self.transferee, self.number)
				
				if self.error.blank?
					client.emit_success RPTokens.move_tokens(self.transferer, self.transferee, self.enactor, self.number)
				else
					client.emit_failure self.error
				end
				
			end
		end
	end
end