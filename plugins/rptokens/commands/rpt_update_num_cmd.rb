module AresMUSH
	module RPTokens
		class  RPTUpdateNum
			include CommandHandler
			
			def self.rpt_update(name, number, reason, client)
				name.update(rpt: name.rpt.to_i + number)
				client.emit_success "#{number} RP Tokens given to #{name}."
			end
		end
	end
end