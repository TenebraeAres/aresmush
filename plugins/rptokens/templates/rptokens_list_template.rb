module AresMUSH
	module RPTokens
		# Template for the list of RPTokens.
		class RPTokensListTemplate < ErbTemplateRenderer
	
			attr_accessor :char
			
			def initialize(char)
				@char = char
				if cmd.switch == "all"
					@loglist = char.rpt_log
				else
					@loglist = char.rpt_log.to_a.last(20)
				end
				super File.dirname(__FILE__) + "/rptokens_list.erb"
			end
		end
	end
end