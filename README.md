# README - Event Volunteer APP 

* Planning

  - All model / controller / gemfile / etc planning is in `planning/`

    - Features are written in `planning/features/` and should each be reflected in a feature test

* Purpose

  - This app is designed as SAAS, to enable festivals to acquire and manage volunteers

* Naming

  - Festivals are called 'Events', as to not pidgeon-hole the perceived capabilities and planning of the app to festivals only

  - All humans with an account are in a single model, 'User', as fits with conventions

    - Authentication is via [Devise](https://github.com/plataformatec/devise)

  - Users have a role, and will be refered to throughout the code as (in order of increasing ability:

    - 'Volunteer' : The User being organised into shifts

    - 'Shift_Manager' : A paid employee of the festival, who manages volunteers

* Ruby version
  - ruby 2.4.0p0 (2016-12-24 revision 57164)

* System dependencies
  - paperclip needs Imagemagick installed

* Configuration

  - ENV variables use Figaro gem.
  - access them through `ENV['my_variable']`

* Database creation

  -rails db:create

* Testing

  - Rspec - `rspec` to run the tests

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

  - Deployments are through Mina
  - Requires Mina gem
  - edit `config/deploy.rb` to change deployment settings

* ...
