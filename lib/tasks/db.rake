namespace :db do
  task sample: :environment do
    Rake::Task["db:seed"].invoke
    load "#{Rails.root}/db/sample.rb"
  end
end
