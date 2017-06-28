ruby '2.4.0'

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.0'
# Use sqlite3 as the database for Active Record
gem 'pg'
# Use Puma as the app server
gem 'puma', '~> 3.7'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
# gem 'webpacker'
# Allows us to play nice with controllers and React
# gem 'react-rails'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Needed for Bootstrap
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'
gem 'annotate'

# USERS // USER MANAGEMENT
  # Authentication
gem 'devise', git: 'https://github.com/plataformatec/devise.git', branch: 'master'
  # Authorization
gem 'cancancan', '~> 1.10'
gem 'rolify'
gem 'omniauth-facebook'

# ADMIN SECTION
# gem 'administrate' # (maybe)

# Nested Models Help
gem "cocoon"

# Payments
gem 'stripe'

# Images
gem 'paperclip'
gem 'delayed_paperclip' # think that's the name

# Content Editing
# gem 'ckeditor' # Make sure to use a sanitizer

# Forms
# TODO - look for newer official version that doesn't break with Rails 5.1
  # https://github.com/plataformatec/simple_form/issues/1485
gem 'simple_form', github: 'elsurudo/simple_form', branch: 'rails-5.1.0'

# Styling
gem 'bootstrap-sass', '~> 3.3.6'
# gem 'rails-assets-tether', '>= 1.3.3', source: 'https://rails-assets.org'
gem 'autoprefixer-rails'
gem 'haml-rails'

# Routes / URLs
gem 'friendly_id'

# Secrets
gem 'figaro'

# Job Worker
gem 'whenever'

# Documentation

gem 'yard'

group :production do
  # gem 'unicorn'
  # Assets in production
  # gem 'rails_12factor'
end


group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13.0'
  gem 'selenium-webdriver'
  gem 'rspec-rails'
  gem 'cucumber'
  gem 'database_cleaner'
  gem 'factory_girl_rails'
end


group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'binding_of_caller'
  gem 'web-console', '>= 3.3.0'
  gem 'better_errors'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'pry-rails'
  gem 'foreman'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
