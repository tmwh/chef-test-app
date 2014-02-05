set :rbenv_type, :user # or :system, depends on your rbenv setup
set :rbenv_ruby, '2.1.0'

#TODO: Check the application name
set :application, 'chef-test'

#TODO: Replace with valid github url
set :repo_url,    'GITHUB_REPO'

ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

set :deploy_to, "/data/apps/#{fetch(:application)}"
set :scm, :git

set :format, :pretty
set :log_level, :debug
set :pty, true

set :linked_files, %w{config/database.yml}
set :linked_dirs, %w{log tmp vendor/bundle db/backups config/settings}

# set :default_env, { path: "/opt/ruby/bin:$PATH" }
set :keep_releases, 5

set :bundle_without, %w{development test utils}.join(' ')

set :git_tag_name, proc { Time.now.to_s.gsub(/[-\s\:\+]+/, '-') }

before 'deploy:migrate', 'db:backup'
after 'deploy:finishing', 'deploy:restart'
after 'deploy:finishing', 'deploy:cleanup'
