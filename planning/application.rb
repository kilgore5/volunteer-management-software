# Use UUIDS instead of id for models

# https://lab.io/articles/2017/04/13/uuids-rails-5-1/

config.generators do |g|
  g.orm :active_record, primary_key_type: :uuid
end