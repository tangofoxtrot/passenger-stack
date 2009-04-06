package :mysql, :provides => :database do
  description 'MySQL Database'
  apt %w( mysql-server mysql-client libmysqlclient15-dev )
  
  verify do
    has_executable 'mysql'
  end
end
 
package :mysql_driver, :provides => :ruby_database_driver do
  description 'Ruby MySQL database driver'
  gem 'mysql'
  
  verify do
    has_gem 'mysql'
  end
  
  requires :mysql, :ruby_enterprise
end

# Packages to install sqlite3 and the sqlite3 ruby driver.
package :sqlite3 do
  description 'SQLite3 database'
  apt 'sqlite3'
end

package :sqlite3_ruby_driver do
  description 'Ruby SQLite3 library.'
  apt 'libsqlite3-dev libsqlite3-ruby1.8'
  
  requires :rubygems
  
  verify do
    ruby_can_load 'sqlite3'
  end
end