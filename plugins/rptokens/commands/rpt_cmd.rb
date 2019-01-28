module AresMUSH
	module RPTokens
		class RPTCmd
			include CommandHandler
			attr_accessor :title, :desc
			
			def check_approved
				return nil if enactor.is_approved? || enactor.is_admin?
				return t('dispatcher.not_allowed')
			end
			
			def parse_args	
				args = cmd.parse_args(ArgParser.arg1_equals_arg2)
				self.title = args.arg1
				self.desc = args.arg2
			end

			def required_args
				[self.title, self.desc]
			end

			def handle
				Jobs.create_job("RPT", self.title, self.desc, enactor)
			end
		end
	end
end