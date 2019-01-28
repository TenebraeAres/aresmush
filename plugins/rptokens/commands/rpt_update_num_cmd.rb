module AresMUSH
	module RPTokens
		class  RPTUpdateNun
			
			attr_accessor :name, :number, :reason
			
			self.name = model.name
			self.number = number
			self.reason = reason
			
			model.update(rpt: self.name.rpt.to_i + self.number)
		end
	end
end