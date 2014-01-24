
namespace :pingtai do

  desc 'drop and create db'
  task :db => ['db:drop','db:create','db:migrate', 'region:import']

end