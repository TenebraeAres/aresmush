module AresMUSH
	class RPTokensLog < Ohm::Model
		include ObjectModel
		
		reference :character, "AresMUSH::Character"
		attribute :reason
		attribute :value, :type => DataType::Integer, :default => 0
		attribute :awarder
		attribute :date

	end
end