module AresMUSH
  module Custom
    class SetGuacCmd
      include CommandHandler
      
      attr_accessor :guac

      def parse_args
       self.guac = trim_arg(cmd.args)
      end

      def handle
        enactor.update(guac: self.guac)
        client.emit_success "You've got to guac it, guac it!"
      end
    end
  end
end
