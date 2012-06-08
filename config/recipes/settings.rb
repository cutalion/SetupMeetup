namespace :settings do
  desc "Generate production settings file."
  task :setup, roles: :app do
    run "mkdir -p #{shared_path}/config/settings"
    template "settings.yml.erb", "#{shared_path}/config/settings/production.yml"
  end
  after "deploy:setup", "settings:setup"


  desc "Symlink production settings file into latest release"
  task :symlink, roles: :app do
    run "ln -nfs #{shared_path}/config/settings/production.yml #{release_path}/config/settings/production.yml"
  end
  after "deploy:finalize_update", "settings:symlink"
end
