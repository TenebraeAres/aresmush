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

		def self.arg1_booltofrom_arg2_optiona_equals_arg3
			/(?<arg1>.*?) (?<bool>to|from) (?<arg2>[^=]*)=?(?<arg3>.*)/
		end
	end
end