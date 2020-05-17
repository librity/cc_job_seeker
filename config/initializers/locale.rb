

# Load all locales in config/locales/*
I18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.yml').to_s]

# Permitted locales available for the application
I18n.available_locales = %i[en pt-BR]

# Set default locale to something other than :en
I18n.default_locale = :'pt-BR'
