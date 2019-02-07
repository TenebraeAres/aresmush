module AresMUSH
	module RPTokens
		# Template for the list of RPTokens.
		class RPTokensListTemplate < ErbTemplateRenderer
	
			attr_accessor :char
			
			def initialize(char, ct)
				@char = char
				@ct = ct
				super File.dirname(__FILE__) + "/rptokens_list.erb"
			end
		end
	end
end