module AresMUSH
  module Page
    class PageAutospaceCmd
      include CommandHandler
      
      attr_accessor :option
      
      def parse_args
        self.option = trim_arg(cmd.args)
      end

      def handle
        
        if (!self.option)
          enactor.update(page_autospace: nil)
          message = t('page.autospace_cleared')
        else
          enactor.update(page_autospace: self.option)
          message = t('page.autospace_set', :option => self.option)
        end
        
        client.emit_success message
        AresCentral.warn_if_setting_linked_preference(client, enactor)
      end
    end
  end
end
