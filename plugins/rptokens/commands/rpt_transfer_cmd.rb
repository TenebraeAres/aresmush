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
				if (cmd.switch_is?("move"))
					args = cmd.parse_args(Custom.arg1_booltofrom_arg2)
					if args.bool = "to"
						self.transferer = enactor.name
						self.transferee = args.arg2
					else
						self.transferee = enactor.name
						self.transferer = args.arg2
					end
				else
					args = cmd.parse_args(Custom.arg1_to_arg2_from_arg3)
					self.transferer = args.arg3
					self.transferee = args.arg2
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
				transferer = Character.find_one_by_name(transferer)
				transferee = Character.find_one_by_name(transferee)

				## If it's the move switch, check if valid and alts.
				if (cmd.switch_is?("move")) 
					if (!transferee || !transferer)
						client.emit_failure "#{args.arg2} doesn't exist."
						return
					elsif not_alt ##Pending code
						bad_name = Character.find_one_by_name(args.arg2)
						client.emit_failure "#{bad_name} isn't your alt!"
						return 
					end

				## Else if it's the transfer switch, check if names are valid and alts.
				elsif (cmd.switch_is?("transfer")) 
					if (!transferer)
						client.emit_failure "#{args.arg3} doesn't exist."
						return
					elsif (!transferee)
						client.emit_failure "#{args.arg2} doesn't exist."
						return
					elsif not_alt ##Pending code
						client.emit_failure "#{self.trasferer.name} isn't an alt of #{self.trasferee.name}!"
						return
					end
				
				## If all other checks are good, check if the transferer has enough points.
				elsif (self.transferer.rpt - self.number < 0)
					client.emit_failure "#{self.transferer.name} doesn't have enough RP Tokens!"
					return
				
				## If all checks are good, do the transfer.
				else
					token_noun = self.number == 1 ? "Token" : "Tokens"
					time = Time.now.strftime("%a %b %d %H:%M:%S %Y")

					self.transferer.update(rpt: self.transferer.rpt - self.number)
					description = "#{self.number} RP #{token_noun} transfered to #{self.transferee.name}"
					RPTokensLog.create(reason: description, value: self.number, awarder: enactor.name, date: time, character: self.transferer)
				
					self.transferee.update(rpt: self.transferee.rpt + self.number)
					description = "#{self.number} RP #{token_noun} transfered from #{self.transferer.name}"
					RPTokensLog.create(reason: description, value: self.number, awarder: enactor.name, date: time, character: self.transferee)

					client.emit_success "#{self.number} RP #{token_noun} transfered from #{self.transferer.name} to #{self.transferee.name}."
				end
			end
		end
	end
end