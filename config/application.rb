require File.expand_path('../boot', __FILE__)

require 'csv'
require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Brightlight
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'
    config.time_zone = 'Jakarta'
    
    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Enable the asset pipeline
    config.assets.enabled = true

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    # Load the local_env.yml file so we can set the local environment variables
    config.before_configuration do
      env_file = File.join(Rails.root, 'config', 'local_env.yml')
      YAML.load(File.open(env_file)).each do |key, value|
        ENV[key.to_s] = value
      end if File.exists?(env_file)
    end

    config.action_mailer.preview_path = "#{Rails.root}/test/mailers/previews"
    
    config.purchasing_pic_name = 'Purchasing'
    config.purchasing_email_address = "\"#{config.purchasing_pic_name}\" <purchasing@cahayabangsa.org>"
    config.default_buyer_email_address = "\"Silvi Natalia S.\" <silvi.sihombing@cahayabangsa.org>"

    config.finance_pic_name = 'Finance'
    config.finance_email_address = "\"#{config.finance_pic_name}\" <finance@cahayabangsa.org>"
  end
end
