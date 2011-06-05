task :arbitrary => :environment do
  eval(ENV['code']) if ENV['code']
end