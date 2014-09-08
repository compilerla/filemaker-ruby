require 'rails'

module Rails
  module Filemaker
    class Railtie < Rails::Railtie
      initializer 'filemaker-load-config-yml' do
        config_file = Rails.root.join('config', 'filemaker.yml')

        if config_file.file?
          Filemaker.load!(config_file, Rails.env)
        else
          fail Error::ConfigurationError, 'No config file provided'
        end
      end
    end
  end
end