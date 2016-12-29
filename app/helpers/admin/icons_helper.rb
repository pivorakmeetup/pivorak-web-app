module Admin
  module IconsHelper
    def icon(name, options = {})
      evil_icon "ei-#{name}", options
    end
  end
end
