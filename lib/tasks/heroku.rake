namespace :heroku do
  task :config do
    puts "Reading config/config.yml and sending PRODUCTION config vars to Heroku..."
    CONFIG = YAML.load_file('config/application.yml')['production'] rescue {}
    command = "heroku config:set"
    CONFIG.each {|key, val|
      command << " #{key}=#{val} " if val
      }
    puts command
    system command
  end
end