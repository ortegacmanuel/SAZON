require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module CAV
  class Application < Rails::Application
    config.autoload_paths += %W(#{config.root}/app/models/ckeditor)
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.slug_regex = /[a-z][_a-z0-9]+/

    # https://mattbrictson.com/dynamic-rails-error-pages
    config.exceptions_app = self.routes
  end
end
