module AresMUSH
	class RPTokensLog < Ohm::Model
		include ObjectModel
		
		reference :character, "AresMUSH::Character"
		attribute :name
		attribute :point, :type => DataType::Integer, :default => 0
		attribute :reason
		attribute :date
		
		index :name
	end
end