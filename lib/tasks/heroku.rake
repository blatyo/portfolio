namespace :heroku do
  desc "Pushes to heroku after some repo acrobatics"
  task :push do
    system "git checkout heroku"
    system "git merge master"
    system "git push heroku heroku:master"
    system "heroku rake db:migrate"
    system "git checkout master"
  end
end