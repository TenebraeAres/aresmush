module AresMUSH
	module RPTokens
		class RPTModifyCmd
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
					if (cmd.switch_is?("add"))
						tokens_to_add = self.number
						message = t('rpt.tokens_given_to', :num => self.number, :name => model.name)
					else 
						if (model.rpt - self.number < 0)
							client.emit_failure "#{model.name} doesn't have enough RP Tokens!"
							return
						else
							tokens_to_add = 0-self.number
							message = t('rpt.tokens_subtracted_from', :num => self.number, :name => model.name)
						end
					end
					client.emit_success message
					model.update(rpt: model.rpt + tokens_to_add)
					RPTokensLog.create(reason: self.reason, value: tokens_to_add, awarder: enactor.name, date: Time.now.strftime("%a %b %d %H:%M:%S %Y"), character: model)
				end
			end
		end
	end
end