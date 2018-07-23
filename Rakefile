require("sinatra/activerecord")
require("sinatra/activerecord/rake")
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

namespace(:db) do
  task(:load_config)
end

namespace :db do
  namespace :test do
    task :prepare => :environment do
      Rake::Task["db:seed"].invoke
    end
  end
end
