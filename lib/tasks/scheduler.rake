desc "This task is called by the Heroku cron add-on"
task :call_page => :environment do
  require 'net/http'
  uri = URI.parse('http://hyaku-1.eure-ka.me/')
  Net::HTTP.get(uri)
end
