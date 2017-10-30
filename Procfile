release: bin/rails db:migrate
web: bin/rails server -p $PORT -e $RAILS_ENV
worker: bundle exec sidekiq -q default -q mailers -t 25