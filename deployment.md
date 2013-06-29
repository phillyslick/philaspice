# RIGHT AT DIGITAL OCEAN
port 21521
user slick

1. I changed user to slick via article here:
https://www.digitalocean.com/community/articles/initial-server-setup-with-ubuntu-12-04

Now going to follow railscasts for order, but install things using guide on digital ocean...
Perhaps I'll only use capistrano to deploy git

update/upgrade
apt-get -y install curl git-core python-software-properties
apt-get -y install nginx
sudo apt-get install chkconfig
sudo apt-get install postgresql libpq-dev
 sudo -u postgres psql
 postgres=# \password
 Enter new password: 
 Enter it again:
 postgres=# create user blog with password 'secret';
 CREATE ROLE
 postgres=# create database blog_production owner blog;
 CREATE DATABASE
 
sudo apt-get -y install nodejs
sudo wget ftp://ftp.ruby-lang.org/pub/ruby/2.0/ruby-2.0.0-p195.tar.gz

sudo apt-get install build-essential openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev  libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev automake libtool bison nodejs subversion sqlite3

tar xvfz
cd into ruby
./configure
make
sudo make install
sudo gem update --system

delete ruby installation folder
then i started following railscasts vps

check the current deploy stuff.
things to remember.
Slick needs access and probably has access to the rusty files
www-data:www-data needs access to the entire app structure, i think

the matcher for assets is incorrect in railscasts nginx conf

use bundle exec for everything...

add what you need to be precompiled

remember to uncomment the correct header for nginx in production.rb
just follow whats here.
now the problem of compiled assets are not ordering correctly 0 media queries


Couple options, im going to try to go all manifest...
move all css media queries inside.
had to restart unicorn - but it works
change deploy so that it works better and/or watch capitsrano episodes.
redis
https://www.digitalocean.com/community/articles/how-to-install-and-use-redis
- install redis
- seems like sidekiq is functioning, but you'll have to check it out via btcfile
-SET REDIS MEMORY - SEEMS LIKE way to much
- Besides a cleaned up deploy,
- Exception notifications
- Othermailers
- Rails Config - Make sure to set production.yml in settings
-SOUNDCLOUD - need to set the callback id.  - This should probably be SSL as well.
-Btcfile NOT NEEDED ANYMORE
run "mkdir -p #{current_path}/tmp/btcfile" for place to store btc uploads.
and add set :shared_children, shared_children + %w{public/uploads} so uploads persist between releases.

YOU NEED TO RUN SOME CACHE CLEARING UTILITIES
