# Rails::Generators::Base dont need a name
# Rails::Generators::NamedBase need a name
module QyWechat
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../../templates', __FILE__)

      desc 'Creates a QyWechat initializer for your application.'

      def install
        route 'mount QyWechat::Engine, at: "/"'
      end

      def copy_initializer
        template 'qy_wechat_config.rb', 'config/initializers/qy_wechat_config.rb'
      end

      def configure_application
        application <<-APP
    config.to_prepare do
      # Load application's model / class decorators
      Dir.glob(File.join(File.dirname(__FILE__), "../app/**/*_decorator*.rb")) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
    end
        APP
      end

      def copy_decorators
        template 'qy_wechat_controller.rb', 'app/decorators/controllers/qy_wechat/qy_wechat_controller_decorator.rb'
      end

    end
  end
end
