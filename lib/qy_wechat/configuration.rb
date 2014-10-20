module QyWechat

  class << self

    attr_accessor :configuration

    def config
      self.configuration ||= Configuration.new
    end

    def configure
      yield config if block_given?
    end

    def qy_model_name
      @qy_model_name ||= QyWechat.config.qy_account
    end

    def qy_model
      if qy_model_name.blank?
        raise "You need to config `qy_account` in 'config/initializers/qy_wechat_config.rb'"
      end
      @qy_model ||= qy_model_name.to_s.constantize
    end

  end

  class Configuration
    attr_accessor :qy_account
  end
end
