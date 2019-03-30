module AresMUSH
  module Custom
    class GuacCmd
      include CommandHandler
      
      attr_accessor :name

      def parse_args
        self.name = cmd.args ? titlecase_arg(cmd.args) : enactor_name
      end
      
      def check_can_view
         return nil if self.name == enactor_name
         return nil if enactor.is_approved? || enactor.is_admin?
         return "You're not allowed to view other peoples' secret level of awesome."
      end      
      
      def handle
        ClassTargetFinder.with_a_character(self.name, client, enactor) do |model|
          template = BorderedDisplayTemplate.new model.goals, "#{model.name}'s Level of Awesome is..."
          client.emit template.render
        end
      end
    end
  end
end
