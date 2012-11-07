Ruby on Rails Tutorial: sample application

###  for all package (not recommand)
rvm pkg install readline  &&  rvm pkg install iconv &&  rvm pkg install curl &&  rvm pkg install openssl &&  rvm pkg install zlib &&  rvm pkg install autoconf &&  rvm pkg install ncurses &&  rvm pkg install pkgconfig &&  rvm pkg install gettext &&  rvm pkg install glib &&  rvm pkg install mono &&  rvm pkg install llvm &&  rvm pkg install libxml2 &&  rvm pkg install libxslt &&  rvm pkg install libyaml

### to skip the checksum of some compres package error like readline 6.2 (not recommand)
rvm pkg install readline --verify-downloads 1 &&  rvm pkg install iconv &&  rvm pkg install curl &&  rvm pkg install openssl &&  rvm pkg install zlib &&  rvm pkg install autoconf &&  rvm pkg install ncurses &&  rvm pkg install pkgconfig &&  rvm pkg install gettext &&  rvm pkg install glib &&  rvm pkg install mono &&  rvm pkg install llvm &&  rvm pkg install libxml2 &&  rvm pkg install libxslt &&  rvm pkg install libyaml--verify-downloads 1

###  to remove the llvm (not support the x86 ubuntu system)
rvm pkg install readline --verify-downloads 1 &&  rvm pkg install iconv &&  rvm pkg install curl &&  rvm pkg install openssl &&  rvm pkg install zlib &&  rvm pkg install autoconf &&  rvm pkg install ncurses --verify-downloads 1 &&  rvm pkg install pkgconfig &&  rvm pkg install gettext --verify-downloads 1 &&  rvm pkg install glib --verify-downloads 1 &&  rvm pkg install mono --verify-downloads 1 &&  rvm pkg install libxml2 --verify-downloads 1 &&  rvm pkg install libxslt --verify-downloads 1 &&  rvm pkg install libyaml--verify-downloads 1

 #BUT from 1.9.3 
 
 rvm install 1.9.3 --with-opt-dir=$rvm_path/usr packages

#############  install rvm and dependencies package ([recommanded method])
sudo apt-gett install build-essential openssl libreadline6 libreadline6-dev curl ssh  git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev automake libtool bison subversion pkg-config 
sudo apt-get install mysql-server libmysqlclient15-dev
sudo apt-get install postgresql libpq-dev
##### apt install  ruby 1.9  by root 
# sudo apt-get install ruby1.9  ruby1.9-dev ruby-railties-3.2   
sudo apt-get install htop iotop sysstat lrzsz 


###  install php and apache 
sudo apt-get install php5 php5-cli
php -v
sudo apt-get install apache2
sudo apt-get install libapache2-mod-auth-mysql
sudo apt-get install php5-mysqlsudo
sudo /etc/init.d/apache2 restart

#####  some suggestion from  https://github.com/wayneeseguin/rvm/issues/614#issuecomment-3173126
### please take care of the package order bellowing 
rvm pkg install openssl &&  rvm pkg install zlib && rvm pkg install libxml2 && rvm pkg install libyaml && rvm pkg install autoconf && rvm --skip-autoreconf pkg install readline  &&  rvm --skip-autoreconf pkg install iconv &&  rvm pkg install curl  

### install the ruby and with the optional parameter 
rvm install 1.9.3 with-readline-dir=$rvm_path/usr --with-iconv-dir==$rvm_path/usr/usr
 --with-zlib-dir==$rvm_path/usr/usr --with-openssl-dir==$rvm_path/usr/usr 
### but you can use 
rvm install 1.9.3 --with-opt-dir=$rvm_path/usr
### set the ruby 1.9.3 as the default
rvm use 1.9.3 --default
### create the gemset rails32  for rails 3.2
rvm gemset create rails32
### set the rails development ruby 1.9.3 + rails32 gemset
rvm use 1.9.3@rails32

### to check the gem version
gem -v
### to install bundle 
gem install  bundle 
### to install rails 3.2
gem install  rails -v=3.2
### to check the rails version
rails -v


# to install  mysql2 
gem install mysql2

# to instal pg  


