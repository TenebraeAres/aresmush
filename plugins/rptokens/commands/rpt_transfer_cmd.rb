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
				args = cmd.parse_args(ArgParser.arg1_equals_arg2)
				if (cmd.switch_is?("move"))
					self.transferer = enactor
				else
					self.transferer = 
				end
				self.number = integer_arg(args.arg1)
				self.reason = "Approved!%r%r" + args.arg2.to_s
			end

			def check_alts
				if ( 0==1 )
					return client.emit_failure ("You may only move RPTs among alts.")
				end
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
				ClassTargetFinder.with_a_character(job.author_name, client, enactor) do |model|
					model.update(rpt: model.rpt + 1)
					client.emit_success "RPT Approved: Job# #{job.id}"
				end
				Jobs.close_job(enactor, job, self.reason)
			end
		end
	end
end