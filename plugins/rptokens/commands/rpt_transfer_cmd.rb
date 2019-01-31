module AresMUSH
	module RPTokens
		class RPTTransferCmd
			include CommandHandler
			attr_accessor :transferer, :transferee, :number
			
			def check_approved
				if (cmd.switch_is?("transfer"))
					return nil if enactor.is_admin?
					return t('dispatcher.not_allowed')
				end
				
			end
			
			def parse_args	
				args = cmd.parse_args(Custom.arg1_to_arg2_from_arg3)
				self.transferer = args.arg3
				self.transferee = args.arg2
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
				
				RPTokens.move_tokens(client, self.transferer, self.transferee, enactor, self.number, args.arg2, args.arg3)
			end
		end
	end
end