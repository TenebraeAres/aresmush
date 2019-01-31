module AresMUSH
	module RPTokens
	
		def self.move_tokens(client, transferer, transferee, enactor, number, arg2, arg3)
			if (cmd.switch_is?("move"))
				if (!transferer || !transferee)
					client.emit_failure "That character doesn't exist."
					return
				elsif not_alt ##Pending code
					client.emit_failure "That character isn't an alt of yours!"
					return
				end
			else
				if (!transferer)
					client.emit_failure "#{arg3} doesn't exist."
					return
				elsif (!transferee)
					client.emit_failure "#{arg2} doesn't exist."
					return
				elsif not_alt ##Pending code
					client.emit_failure "#{self.trasferer.name} isn't an alt of #{self.trasferee.name}!"
					return
				end
			end

			if (self.transferer.rpt - self.number < 0)
				client.emit_failure "#{self.transferer.name} doesn't have enough RP Tokens!"
				return
				
			## If all checks are good, do the transfer.
			else
				token_noun = self.number == 1 ? "Token" : "Tokens"
				time = Time.now.strftime("%a %b %d %H:%M:%S %Y")

				self.transferer.update(rpt: self.transferer.rpt - self.number)
				description = "#{self.number} RP #{token_noun} transfered to #{self.transferee.name}"
				RPTokensLog.create(reason: description, value: self.number, awarder: enactor.name, date: time, character: self.transferer)
			
				self.transferee.update(rpt: self.transferee.rpt + self.number)
				description = "#{self.number} RP #{token_noun} transfered from #{self.transferer.name}"
				RPTokensLog.create(reason: description, value: self.number, awarder: enactor.name, date: time, character: self.transferee)

				client.emit_success "#{self.number} RP #{token_noun} transfered from #{self.transferer.name} to #{self.transferee.name}."
			end
		end
	end
end