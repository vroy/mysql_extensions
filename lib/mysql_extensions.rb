$LOAD_PATH.unshift("#{File.dirname(__FILE__)}/")

require 'mysql'
require 'bigdecimal'

require "mysql_extensions/options"
require "mysql_extensions/pretty_table"
require "mysql_extensions/log"
require "mysql_extensions/db"
require "mysql_extensions/result"
require "mysql_extensions/row"
require "mysql_extensions/types"
require "mysql_extensions/mixins/string"
require "mysql_extensions/mixins/object"


#TODO: Rename to mysql_extensions

class Mysql
  #TODO: Add .valid? as an extension to row.
  #TODO: Someone can then do: class Car < Row; def valid?; true; end; end
  #TODO: or class Car < Row; ValidationProcs = [[:col, lambda], [:col, lambda]]; end
  
end
