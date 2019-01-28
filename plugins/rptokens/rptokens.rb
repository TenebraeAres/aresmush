module AresMUSH
  module RPTokens
    def self.plugin_dir
      File.dirname(__FILE__)
    end
	def self.get_cmd_handler(client, cmd, enactor)
		case cmd.root
		when "rpt"
			args = cmd.parse_args(ArgParser.arg1_equals_arg2)
			if arg2.any?
				return RPTCmd
			end
		end
		return nil
	end
  end
end