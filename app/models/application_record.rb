class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  config.generators do |g|
    g.assets false
    g.helper false
    g.jbuilder false
  end
end
