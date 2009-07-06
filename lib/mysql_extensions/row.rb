class Mysql
  # Simple wrapper around the hash returned by fetch_hash.
  # 
  # It allows the following reads:
  #   obj.name
  #   obj[:name]
  #   obj["name"]
  # 
  # Since we are an Hash superclass, every hash methods are allowed.
  #
  # There is basic typecasting, see Mysql::Typecast. Defaults to to_s
  module Included
    class Row < Hash
      attr_reader :fields
      
      def initialize(hash={})
        hash.each{|k,v| self[k.to_s] = v}
      end
      
      def escaped
        esc = {}
        self.each do |k, v|
          esc[k] = v.e_s_q
        end
        Row.new(esc)
      end
      
      def columns
        keys
      end
      
      def [](key)
        super(key.to_s)
      end
      
      #TODO: Instead of using method_missing I should probably add the methods.
      #TODO: For example, object.id doesn't work because the method already exists.
      #TODO: 
      #TODO: Also add .key = value
      def method_missing(m,*a)
        self[m]
      end
      
      def self.convert(hash, row_fields, with_table)
        converted_hash = {}
        table_name = hash.keys.first.split(".").first
        
        fields = {}
        row_fields.each do |field|
          fields[self.get_key(field.name, with_table, table_name)] = field
        end
        
        hash.each do |key, value|
          key = self.get_key(key, with_table, table_name)
          type_proc = MYSQL_TYPES[fields[key].type]
          
          begin
            converted_hash[key] = type_proc.call(value)
          rescue Exception => e
            converted_hash[key] = value.to_s
          end
        end
        
        Row.new(converted_hash)
      end
      
      private
      def self.get_key(key, with_table, table_name)
        if key.split(".").size > 1
          key.gsub(".", "__")
        elsif with_table
          "#{table_name}__#{key}"
        else
          key
        end
      end
    end
  end
  
  include Mysql::Included
end

include Mysql::Included
