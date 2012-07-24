require "bundler/capistrano"

default_run_options[:pty] = true

set :application, "Opportux"
set :repository, "git@github.com:kurniaone/opportux.git"
set :scm, :git
set :user, "root"
set :deploy_via, :remote_cache
set :deploy_to, "/rails-app/opportux"
set :keep_releases, 5
set :use_sudo, false
ssh_options[:forward_agent] = true
set :default_environment, {
  'PATH' => "/root/.rbenv/shims:/root/.rbenv/bin:$PATH"
}

set :domain, "66.212.17.114"
set :branch, "master"
set :rails_env, "development"
set :migrate_target, :latest
role :web, domain
role :app, domain
role :db, domain, :primary => true

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart do
    run "#{try_sudo} touch #{File.join(current_path, "tmp", "restart.txt")}"
  end
end

namespace :symlinks do
  task :database_yml, :roles => :app do
    run "ln -sfn #{shared_path}/database.yml #{release_path}/config/database.yml"
  end
end

namespace :assets do
  task :precompile, :roles => :web do
    run "cd #{current_path}; rm -rf public/assets/*"
    run "cd #{current_path}; RAILS_ENV=production bundle exec rake assets:precompile --trace"
    run "cp -rf #{current_path}/public/assets/web-app-theme/themes/default/images/ #{current_path}/public/assets/images/"
    run "cp -rf #{current_path}/public/assets/web-app-theme/themes/default/fonts/ #{current_path}/public/assets/fonts/"
    run "mv #{current_path}/public/assets/ui-*.png #{current_path}/public/assets/images/"
  end
end

after "deploy:finalize_update", "symlinks:database_yml"
after 'deploy:update', 'deploy:migrate'
# after 'deploy:update', 'assets:precompile'
after "deploy:update", "deploy:cleanup"
