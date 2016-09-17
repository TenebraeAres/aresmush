require_relative "../../plugin_test_loader"

module AresMUSH
  module Manage
    describe LoadConfigCmd do
      include CommandHandlerTestHelper
      include GlobalTestHelper
  
      before do
        init_handler(LoadConfigCmd, "load config")
        SpecHelpers.stub_translate_for_testing
        stub_global_objects
      end
      
      it_behaves_like "a plugin that requires login"
      
      describe :handle do
        it "should load config and notify client" do           
          config_reader.should_receive(:load_game_config) {}
          plugin = double
          plugin_manager.stub(:plugins) { [plugin] }
          plugin.stub(:plugin_dir) { "A" }
          plugin.stub(:help_files) { [ "help" ]}
          config_reader.should_receive(:load_plugin_config).with("A", [ "help" ] ) {}
          client.should_receive(:emit_success).with('manage.config_loaded')
          handler.handle
        end
          
        it "should handle errors from config load" do
          config_reader.should_receive(:load_game_config) { raise "Error" }
          client.should_receive(:emit_failure).with('manage.error_loading_config')
          handler.handle
        end          
      end
    end
  end
end