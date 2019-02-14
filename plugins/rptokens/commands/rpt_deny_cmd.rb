module AresMUSH
	module RPTokens
		class RPTDenyCmd
			include CommandHandler
			attr_accessor :number, :reason
			
			def check_approved
				return nil if enactor.is_admin?
				return t('dispatcher.not_allowed')
			end
			
			def parse_args	
				args = cmd.parse_args(ArgParser.arg1_equals_optional_arg2)
				self.number = integer_arg(args.arg1)
				self.reason = "Denied.%r%r" + args.arg2.to_s
			end

			def handle
				job = Job[self.number]
				if (!job || !job.is_open?)
					client.emit_failure "That's not a valid job number!"
					return
				end
				
				if (job.category != "RPT")
					client.emit_failure "That's not an RPT job!"
					return
				end
				Jobs.close_job(enactor, job, self.reason)
				client.emit_success "#{enactor} denied and closed job ##{job.id}"
			end
		end
	end
end