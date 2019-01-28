module AresMUSH
	module RPTokens
		class  RPTUpdateNum
			
			def self.rpt_update(name, number, reason)
				name.update(rpt: name.rpt.to_i + self.number)
			end
		end
	end
end