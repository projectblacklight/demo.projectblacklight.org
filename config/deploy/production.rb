# server-based syntax
# ======================
# Defines a single server with a list of roles and multiple properties.
# You can define all roles on a single server, or split them:

server 'gluck.cul.columbia.edu', user: 'deploy', roles: %w{app db web}


set :linked_files, fetch(:linked_files, []).push('db/production.sqlite3')
set :deploy_to, '/var/www/html/demo.projectblacklight.org'
set :rails_env, "production"
