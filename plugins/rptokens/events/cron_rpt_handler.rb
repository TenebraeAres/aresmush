module AresMUSH
	module RPTokens
		class RPTJobProcessEvent
			def on_event(event)
				config = Global.read_config("rptokens", "rpt_cron")
				return if !Cron.is_cron_match?(config, event.time)
				
				Job.all.select { |j| j.category == "RPT" && j.is_open? &&
				  ((Time.now - j.created_at) / 86400) >= 2}.each do |j|
					Global.client_monitor.emit_all "Job ##{j.id}"
				end
			end
		end
	end
end