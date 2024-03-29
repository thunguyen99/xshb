set :application, "xshb"
set :deploy_to, "/var/www/channely.cn/#{application}"

# Edit Capfile and add the following to it. This ensures that remote capistrano deployment does not fork a remote shell using command “sh -c”. Some hosting servers do not allow remote shells.
default_run_options[:shell] = false

# set :use_sudo, true
set :use_sudo, false

# Whatever you set here will be taken set as the default RAILS_ENV value
# on the server. Your app and your hourly/daily/weekly/monthly scripts
# will run with RAILS_ENV set to this value.
set :rails_env, "production"

# NOTE: for some reason Capistrano requires you to have both the public and
# the private key in the same folder, the public key should have the
# extension ".pub".
ssh_options[:keys] = ["#{ENV['HOME']}/.ssh/id_rsa"]

set :scm, :git
set :scm_verbose, true
set :branch, "master"
#set :scm_user, 'alexchien'
#set :scm_passphrase, "alexgem"
set :repository,  "git@github.com:AlexChien/xshb.git"
set :deploy_via, :remote_cache

# 180 上跑rails应用的用户
# set :user, "mongrel"
# set :runner, "mongrel"

# 184 上跑rails应用的用户
set :user, "runner"
set :runner, "runner"


set :domain, "180.153.142.114"  #hp1vm2
# 若要用180跑，需要把assets目录从184用nfs mount过来
# mount 192.168.2.170:/usr/local/webservice/htdocs/assets \
# /usr/local/webservice/htdocs/ey-video-app/shared/assets
# set :domain, "202.109.80.180"
role :app, domain
role :web, domain
#role :product, "192.168.1.1"
#role :pre_product, "192.168.1.2"
role :db,  domain, :primary => true

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end

# 不用mongrel，改用thin运行本应用
## Add mongrel cluster support ##
require 'mongrel_cluster/recipes'
set :mongrel_conf, "#{shared_path}/config/mongrel_cluster.yml"
set :mongrel_user, "mongrel"


# add misc task here
namespace :deploy do

  # 覆盖capistrano默认行为，添加thin的启动停止命令
  # desc "用应用下的config/thin.yml用thin启动应用"
  # %w(start stop restart).each do |action|
  #   desc "#{action} the Thin processes"
  #   task action.to_sym do
  #     find_and_execute_task("thin:#{action}")
  #   end
  # end

  desc "Generate database.yml and Create asset packages for production, minify and compress js and css files"
  after "deploy:update_code", :roles => [:web] do
    database_yml
    # thin_yml
    app_config
    asset_packager
  end

  # add soft link script for deploy
  desc "Symlink the directories"
  after "deploy:create_symlink", :roles => [:web] do
    ## create link for shared assets
    run "ln -nfs #{deploy_to}/#{shared_dir}/assets #{release_path}/public/images/assets"

    # backup_db
    migrate
  end

  # customized tasks
  desc "Backup Mysql"
  task :backup_db, :roles => [:web] do
  run "#{shared_path}/script/mysql_backup.pl xshb_production:utf8 #{releases.last} "
  end

  desc "Generate Production database.yml"
  task :database_yml, :roles => [:web] do
    db_config = "#{shared_path}/config/database.yml.production"
    run "cp #{db_config} #{release_path}/config/database.yml"
  end

  desc "Create asset packages for production, minify and compress js and css files"
  task :asset_packager, :roles => [:web] do
    run <<-EOF
    cd #{release_path} && rake RAILS_ENV=production asset:packager:build_all
    EOF
  end

  desc "Generate Production thin.yml"
  task :thin_yml, :roles => [:web] do
    thin_config = "#{shared_path}/config/thin.yml.production"
    run "cp #{thin_config} #{release_path}/config/thin.yml"
  end

  desc "Generate app_config.yml"
  task :app_config, :roles => [:web] do
    app_config = "#{shared_path}/config/app_config.yml.production"
    run "cp #{app_config} #{release_path}/config/app_config.yml"
  end

  # more info about automatially update and incoporate REASON and UNTIL variable
  # check this out: http://www.letrails.cn/archives/customize-capistrano-maintenance-page
  namespace :web do
    task :disable do
      on_rollback { delete "#{shared_path}/system/maintenance.html" }
      maintenance = File.read("./public/maintenance.html")
      put maintenance, "#{shared_path}/system/maintenance.html", :mode => 0644
    end
  end
end

# 控制thin
namespace :thin do
  desc "用应用下的config/thin.yml用thin启动应用"
  %w(start stop restart).each do |action|
  desc "#{action} the app's Thin Cluster"
    task action.to_sym, :roles => :app do
      # run "thin #{action} -c #{deploy_to}/current -C #{deploy_to}/current/config/thin.yml"
      run "thin #{action} -C #{shared_path}/config/thin.yml.production"
    end
  end
end