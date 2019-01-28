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
			
			def check_reason
				self.reason = "%xgApproved!%xn" if self.reason == 0
			end

			def handle
				job = Job[self.number]
				if (job.is_open? == false)
					client.emit_failure "That's not a valid job number!"
					return
				end
				
				if (job.category != "RPT")
					client.emit_failure "That's not an RPT job!"
					return
				end
				
				client.emit_success "RPT Approved: #{self.number} #{self.reason}" 
			end
		end
	end
end