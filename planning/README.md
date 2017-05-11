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

