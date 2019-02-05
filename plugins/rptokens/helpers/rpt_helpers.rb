module AresMUSH
	module RPTokens
		def self.check_move(transferer, transferee, number)

			if (!transferer || !transferee)
				return "That character doesn't exist. %r"
			elsif AresCentral.are_chars_linked?(transferer, transferee)
				return "That charcter isn't an alt of yours! "
			end
			if (self.transferer.rpt - number < 0)
				return "#{transferer.name} doesn't have enough RP Tokens!"
			end
			
		end
		
		
		def self.check_transfer(transferer, transferee, number, name1, name2)
			
			if (!transferer || !transferee)
				message = ""
				if (!transferer)
					message << "#{name1} doesn't exist."
				end
				if (!transferee)
					message << "#{name2} doesn't exist."
				end
				return message
			end
			if AresCentral.are_chars_linked?(transferer, transferee)
				return "#{trasferer.name} isn't an alt of #{trasferee.name}!"
			end
			if (self.transferer.rpt - number < 0)
				return "#{transferer.name} doesn't have enough RP Tokens!"
			end
			
		end
	
	
		def self.move_tokens(transferer, transferee, enactor, number)
			
			token_noun = number == 1 ? "Token" : "Tokens"
			time = Time.now.strftime("%a %b %d %H:%M:%S %Y")

			transferer.update(rpt: transferer.rpt - number)
			description = "#{number} RP #{token_noun} transfered to #{transferee.name}"
			RPTokensLog.create(reason: description, value: number, awarder: enactor.name, date: time, character: transferer)
			
			transferee.update(rpt: transferee.rpt + number)
			description = "#{number} RP #{token_noun} transfered from #{transferer.name}"
			RPTokensLog.create(reason: description, value: number, awarder: enactor.name, date: time, character: transferee)

			return "#{number} RP #{token_noun} transfered from #{transferer.name} to #{transferee.name}."
			
		end
	end
end