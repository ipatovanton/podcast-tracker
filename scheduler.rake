desc "This task is called by the Heroku scheduler add-on"
task :ping => :environment do
  require 'net/http'

  if ENV['PING_URL']
    puts "Pinging #{ENV['PING_URL']}"
    uri = URI(ENV['PING_URL'])
    Net::HTTP.get_response(uri)
  end
end