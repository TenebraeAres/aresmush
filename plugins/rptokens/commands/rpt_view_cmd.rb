module AresMUSH
	module RPTokens
		class RPTViewCmd
			include CommandHandler
			attr_accessor :name
			
			def parse_args
				if (!cmd.args)
					self.name = enactor.name
				else
					self.name = cmd.args
				end
			end

			def check_approved
				if enactor.name != self.name
					return nil if enactor.is_admin? || AresCentral.are_chars_linked?(enactor, name)
					return t('dispatcher.not_allowed')
				end
			end
			
			def handle
				ClassTargetFinder.with_a_character(self.name, client, enactor) do |model|
					template = RPTokensListTemplate.new model
					client.emit template.render
				end
			end
		end
	end
end