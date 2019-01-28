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
				args = cmd.parse_args(ArgParser.arg1_equals_optional_arg2)
				self.number = integer_arg(args.arg1)
				self.reason = "Approved!%r%r" + args.arg2.to_s
			end

			def handle
				job = Job[self.number]
				if (!job)
					client.emit_failure "That's not a valid job number!"
					return
				end
				
				if (job.category != "RPT")
					client.emit_failure "That's not an RPT job!"
					return
				end
				ClassTargetFinder.with_a_character(job.author_name, client, enactor) do |model|
					model.update(rpt: model.rpt + 1)
					client.emit_success "RPT Approved: Job#" + job
				end
				Jobs.close_job(enactor, job, self.reason)
			end
		end
	end
end