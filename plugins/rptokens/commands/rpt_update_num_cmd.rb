module AresMUSH
	module RPTokens
		class  RPTUpdateNum
			include CommandHandler
			
			def self.rpt_update(name, number, reason, client)
				name.update(rpt: name.rpt.to_i + number)
			end
		end
	end
end