module AresMUSH
	module RPTokens
		class  RPTUpdateNum
			
			def self.rpt_update(name, number, reason, enactor)
				name.update(rpt: name.rpt.to_i + number)
				enactor.emit_success "#{number} RP Tokens given to #{name}."
			end
		end
	end
end