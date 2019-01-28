module AresMUSH
  class Character
    attribute :rpt, :type => DataType::Integer
	collection :rpt_log, "AresMUSH::RPTokensLog"
  end
end