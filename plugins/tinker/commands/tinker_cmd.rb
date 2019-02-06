module AresMUSH
  module Tinker
    class TinkerCmd
      include CommandHandler
      attr_accessor :message
      
      
      def check_can_manage
        return t('dispatcher.not_allowed') if !enactor.has_permission?("tinker")
        return nil
      end
      
      def handle
        
        client.emit Job[5].created_at
        client.emit_success Time.at(DateTime.now).to_date
        client.emit_success Time.at(Job[5].created_at).to_date + 1
        client.emit_success (Time.now - Job[5].created_at) / 86400
        Job.all.select { |j| j.category == "RPT" && j.is_open? && 
          ((Time.now - j.created_at) / 86400) >= 2}.each do |j|
			client.emit_success "Job ##{j.id}"
		end
        client.emit_success "Done!"
      end

    end
  end
end
