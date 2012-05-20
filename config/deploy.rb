require "bundler/capistrano"

set :stages, %w(production staging)
set :default_stage, "production"
require 'capistrano/ext/multistage'

load "config/recipes/base"
load "config/recipes/nginx"
load "config/recipes/unicorn"
load "config/recipes/mongoid"
# load "config/recipes/postgresql"
# load "config/recipes/nodejs"
load "config/recipes/rbenv"
load "config/recipes/check"
load "config/recipes/settings"

server "91.218.28.28", :web, :app, :db, primary: true

set :application, "setupmeetup"
set :user, "setupmeetup"
set :deploy_to, "/home/#{user}/apps/#{application}/#{rails_env}"
set :deploy_via, :remote_cache
set :use_sudo, false

set :scm, "git"
# set :repository, "git@github.com:cutalion/#{application}.git"
set :repository, "git@github.com:cutalion/SetupMeetup.git"
set :branch, "master"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

after "deploy", "deploy:cleanup" # keep only the last 5 releases
