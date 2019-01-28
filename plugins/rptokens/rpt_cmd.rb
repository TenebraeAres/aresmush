module AresMUSH
	module RPTokens
		class RPTCmd
			include CommandHandler
			def handle
				client.emit_success "RPTokens Accessed!"
			end
		end
	end
end