# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'test-capistrano'
set :repo_url, 'https://github.com/shhetri/capistrano-deployment-test.git'
set :deploy_to, '/home/vagrant/www/app/staging'

namespace :environment do
    desc "Set environment variables"
    task :set_variables do
        on roles(:app) do
              puts ("--> Create enviroment configuration file")
              execute "cat /dev/null > #{fetch(:app_path)}/.env"
              execute "echo APP_DEBUG=#{fetch(:app_debug)} >> #{fetch(:app_path)}/.env"
              execute "echo APP_KEY=#{fetch(:app_key)} >> #{fetch(:app_path)}/.env"
        end
    end
end

namespace :composer do
    desc "Running Composer Install"
    task :install do
        on roles(:app) do
            within release_path do
                execute :composer, "install --no-dev --quiet"
                execute :composer, "dumpautoload"
            end
        end
    end
end

# namespace :php5 do
#     desc 'Restart php5'
#         task :restart do
#             on roles(:web) do
#             execute :sudo, :service, "php5-fpm restart"
#         end
#     end
# end

namespace :deploy do
  after :updated, "composer:install"
  after :finished, "environment:set_variables"
end

after "deploy",   "php5:restart"


