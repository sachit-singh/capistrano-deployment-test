server '192.168.10.10', user: 'vagrant', roles: %w{app db web}

set :app_path, '/home/vagrant/www/app/staging/current'
set :app_debug, 'false'
set :app_key, '7DpgAdbm46mBzUWnMH6XT6DlgDW9tcLK'