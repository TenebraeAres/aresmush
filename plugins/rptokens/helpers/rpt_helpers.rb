module AresMUSH
	module RPTokens
		def self.check_move(transferor, transferee, number)

			if (!transferor || !transferee)
				return "That character doesn't exist. %r"
			elsif !AresCentral.are_chars_linked?(transferor, transferee)
				return "That charcter isn't an alt of yours! "
			end
			if (transferor.rpt - number < 0)
				return "#{transferor.name} doesn't have enough RP Tokens!"
			end
			
		end
		
		
		def self.check_transfer(transferor, transferee, number, name2, name1)
			
			if (!transferor || !transferee)
				message = ""
				if (!transferor)
					message << "#{name1} doesn't exist."
				end
				if (!transferee)
					message << "#{name2} doesn't exist."
				end
				return message
			end
			unless AresCentral.are_chars_linked?(transferor, transferee)
				return "#{transferor.name} isn't an alt of #{transferee.name}!"
			end
			if (transferor.rpt - number < 0)
				return "#{transferor.name} doesn't have enough RP Tokens!"
			end
			
		end
	
	
		def self.move_tokens(transferor, transferee, enactor, number)
			
			token_noun = number == 1 ? "Token" : "Tokens"
			time = Time.now.strftime("%a %b %d %H:%M:%S %Y")

			transferor.update(rpt: transferor.rpt - number)
			description = "#{number} RP #{token_noun} transferred to #{transferee.name}"
			RPTokensLog.create(reason: description, value: number, awarder: enactor.name, date: time, character: transferor)
			
			transferee.update(rpt: transferee.rpt + number)
			description = "#{number} RP #{token_noun} transferred from #{transferor.name}"
			RPTokensLog.create(reason: description, value: number, awarder: enactor.name, date: time, character: transferee)

			return "#{number} RP #{token_noun} transferred from #{transferor.name} to #{transferee.name}."
			
		end
	end
end