module AresMUSH
	module RPTokens
		# Template for the list of RPTokens.
		class RPTokensListTemplate < ErbTemplateRenderer
	
			attr_accessor :char, :paginator
			
			def initialize(char, paginator)
				@char = char
				@paginator = paginator
				super File.dirname(__FILE__) + "/rptokens_list.erb"
			end
		end
	end
end