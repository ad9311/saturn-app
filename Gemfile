source 'https://rubygems.org'

ruby '3.2.3'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 7.1.3', '>= 7.1.3.2'

# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '>= 5.0'

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
# gem "jbuilder"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[windows jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Use devise for user authentication
gem 'devise'

# Use devise-jwt to use JWT tokens for authentication
gem 'devise-jwt'

# Use dockerfile-rails to manage Dockerfiles
gem 'dockerfile-rails', '>= 1.6', group: :development

# Use kaminari for pagination
gem 'kaminari'

# Use faker to populate seeds
gem 'faker'

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin Ajax possible
gem 'rack-cors'

# Use figaro for managing env variables
gem 'figaro'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[mri windows]

  # Use rspec-rails for unit testing
  gem 'rspec-rails', '~> 6.1.0'
end

group :test do
  # Use database_cleaner for cleaning the test database
  gem 'database_cleaner'
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem 'web-console'

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"

  # Use rubocop-rails for linters
  gem 'rubocop-rails'

  # Use annotate to display tables in models
  gem 'annotate'

  # Use hirb format query in the console
  gem 'hirb'

  # Use solagraph as Ruby Language Server
  gem 'solargraph'

  # Use solagraph-rails as Ruby on Rails Language Server
  gem 'solargraph-rails'
end
