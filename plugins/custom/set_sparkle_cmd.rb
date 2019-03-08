module AresMUSH
  module Custom
    class SetSparkleCmd
      include CommandHandler
      
      attr_accessor :sparkle

      def parse_args
       self.sparkle = trim_arg(cmd.args)
      end

      def handle
        enactor.update(sparkle: self.sparkle)
        client.emit_success "You sparkle over #{self.sparkle}! Like a true elf!"
      end
    end
  end
end
