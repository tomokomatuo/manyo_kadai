module Manyo
  class Application < Rails::Application
    config.generators do |g|
      g.javascripts false
      g.helper false
      g.test_framework false
    end
  end
end
