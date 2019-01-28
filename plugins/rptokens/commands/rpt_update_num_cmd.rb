module AresMUSH
	module RPTokens
		class  RPTUpdateNun
			
			attr_accessor :name, :number, :reason
			
			self.name = name
			self.number = number
			self.reason = reason
			
			self.name.update(rpt: self.name.rpt.to_i + self.number)
		end
	end
end