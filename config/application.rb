require_relative 'boot'

require 'csv'
require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module VolunteerManagementPlatform
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Use UUIDS instead of id for models

    # https://lab.io/articles/2017/04/13/uuids-rails-5-1/

    config.generators do |g|
      g.orm :active_record, primary_key_type: :uuid
    end


    config.time_zone = 'Melbourne'
    config.active_record.default_timezone = :local

  end
end
