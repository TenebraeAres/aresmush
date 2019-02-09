module AresMUSH
	module RPTokens
		class RPTSubmitCmd
			include CommandHandler
			attr_accessor :title, :desc
			
			def check_approved
				return nil if enactor.is_approved? || enactor.is_admin?
				return t('dispatcher.not_allowed')
			end
			
			def parse_args	
				args = cmd.parse_args(ArgParser.arg1_equals_arg2)
				self.title = args.arg1
				self.desc = args.arg2.to_s
			end

			def required_args
				[self.title, self.desc]
			end

			def handle
				count = self.desc.scan(/[^\.!?]+[\.!?]/).map(&:strip).count
				if count < 3
					client.emit_failure "Please resubmit with more about the scene."
				else
					self.desc = "Players: #{enactor.name} %r%r" + self.desc
					Jobs.create_job("RPT", self.title, self.desc, enactor)
					client.emit_success "Your RPT request is successfully submitted!"
				end
			end
		end
	end
end