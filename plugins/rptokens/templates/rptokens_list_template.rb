module AresMUSH
	module Jobs
		# Template for the list of RPTokens.
		class RPTokensListTemplate < ErbTemplateRenderer
	
			attr_accessor :char
			
			def initialize(char, client)
				@char = char
				super File.dirname(__FILE__) + "/rptokens_list.erb"
			end
		end
	end
end