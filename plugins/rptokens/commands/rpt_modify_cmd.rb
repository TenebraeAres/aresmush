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
						tokens_to_add = 0-self.number
						message = t('rpt.tokens_subtraced_from', :num => self.number, :name => model.name)
					end
					client.emit_success message
					model.update(rpt: model.rpt.to_i + self.number)
				end
			end
		end
	end
end