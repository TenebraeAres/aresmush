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
			
			def handle
				char = Character.find_one_by_name(self.name)
				
				error = Custom.alt_check(enactor, char)
				
				if (!error)
					paginator = Paginator.paginate(char.rpt_log.to_a.reverse, cmd.page, 20)
					template = RPTokensListTemplate.new(char, paginator)
					client.emit template.render
				else
					client.emit_failure error
				end
			end
		end
	end
end