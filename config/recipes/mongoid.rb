set_default(:mongo_host, "localhost")
set_default(:mongo_port, "27017")
set_default(:mongo_user)     { "#{application}_#{rails_env}" }
set_default(:mongo_password) { Capistrano::CLI.password_prompt "Mongo password: " }
set_default(:mongo_database) { "#{application}_#{rails_env}" }

namespace :mongoid do
  desc "Install the latest stable release of mongoid."
  task :install, roles: :db, only: {primary: true} do
    run "#{sudo} apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10"
    run "#{sudo} echo '# Mongo' >> /etc/apt/sources.list"
    run "#{sudo} echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' >> /etc/apt/sources.list"
    run "#{sudo} apt-get -y update"
    run "#{sudo} apt-get -y install mongodb-10gen"
  end
  after "deploy:install", "mongoid:install"

  desc "Create a database for this application."
  task :create_indexes, roles: :db, only: { primary: true } do
    run "cd #{current_path} && bundle exec rake db:mongoid:create_indexes", :once => true
  end

  desc "Generate the mongoid.yml configuration file."
  task :setup, roles: :app do
    run "mkdir -p #{shared_path}/config"
    template "mongoid.yml.erb", "#{shared_path}/config/mongoid.yml"
  end
  after "deploy:setup", "mongoid:setup"

  desc "Symlink the mongoid.yml file into latest release"
  task :symlink, roles: :app do
    run "ln -nfs #{shared_path}/config/mongoid.yml #{release_path}/config/mongoid.yml"
  end
  after "deploy:finalize_update", "mongoid:symlink"
end
