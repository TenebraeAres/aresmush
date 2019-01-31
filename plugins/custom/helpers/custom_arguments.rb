module AresMUSH
	module Custom
		def self.arg1_booltofrom_arg2
			/(?<arg1>.*?) (?<bool>to|from) (?<arg2>.*?)/
		end

		def self.arg1_booltofrom_arg2_slash_arg3
			/(?<arg1>.*?) (?<bool>to|from) (?<arg2>[^\/]*)\/(?<arg3>.*)/
		end

		def self.arg1_booltofrom_arg2_optional_slash_arg3
			/(?<arg1>.*?) (?<bool>to|from) (?<arg2>[^\/]*)\/?(?<arg3>.*)/
		end

		def self.arg1_booltofrom_arg2_equals_arg3
			/(?<arg1>.*?) (?<bool>to|from) (?<arg2>[^=]*)=(?<arg3>.*)/
		end

		def self.arg1_booltofrom_arg2_optional_equals_arg3
			/(?<arg1>.*?) (?<bool>to|from) (?<arg2>[^=]*)=?(?<arg3>.*)/
		end
		
		def self.arg1_to_arg2
			/(?<arg1>.*) to (?<arg2>.*)/
		end
				
		def self.arg1_to_arg2_from_arg3
			/(?<arg1>.*) to (?<arg2>.*) from (?<arg3>.*)/
		end
	end
end