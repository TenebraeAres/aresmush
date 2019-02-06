module AresMUSH
	module Custom
	
		def self.alt_check(char1, char2)
			if char1.name != char2.name
				return nil if enactor.is_admin?
				return nil if AresCentral.are_chars_linked?(char1, char2)
				return t('dispatcher.not_allowed')
			end
		end
		
	end
end