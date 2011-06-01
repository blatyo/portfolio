task :cron do
  require 'open-uri'
  open('http://www.forkable.me/keep-alive.html'){}
end