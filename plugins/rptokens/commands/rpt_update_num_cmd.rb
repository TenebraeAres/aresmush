module AresMUSH
	module RPTokens
		class  RPTUpdateNum (name, number, reason)
			
			attr_accessor :name, :number, :reason
			
			:name = name
			:number = number
			:reason = reason
			
			name.update(rpt: model.rpt.to_i + self.number)
		end
	end
end