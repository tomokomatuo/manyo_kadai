server '54.238.8.15', user: 'app', roles: %w{app db web}
set :ssh_options, keys: '/Users/matsuotomoko/.ssh/id_rsa'