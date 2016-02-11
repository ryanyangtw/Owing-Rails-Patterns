require "active_model"
require "connection_adapter"
require "pry"

module ActiveRecord
  class Base
    include ActiveModel::Validations

    @@connection = SqliteAdapter.new

    def initialize(attributes={})
      @attributes = attributes
    end

    def table_name
      self.class.table_name # Base.table_name
    end

    def method_missing(name, *args)
      columns = @@connection.columns(table_name)  

      if columns.include?(name)
        @attributes[name]
      else
        super
      end
    end

    def self.find(id)
      # attributes = @@connection.execute("SELECT * FROM #{table_name} WHERE id = #{id.to_i} LIMIT 1").first
      # new attributes
      find_by_sql("SELECT * FROM #{table_name} WHERE id = #{id.to_i} LIMIT 1").first
    end

    def self.all
      find_by_sql("SELECT * FROM #{table_name}")
    end

    def self.find_by_sql(sql)
      @@connection.execute(sql).map do |attributes| # [ attributes, attributes, attributes ]
        new attributes
      end
    end

    def self.table_name
      # User.name => "User"
      name.downcase + "s" # => "users"
    end

  end
end



# require "connection_adapter"

# module ActiveRecord
#   class Base
#     @@connection = SqliteAdapter.new

#     def initialize(attributes={})
#       @attributes = attributes
#     end

#     def table_name
#       self.class.table_name
#     end

#     def method_missing(name, *args)
#       columns = @@connection.columns(table_name)

#       if columns.include?(name)
#         @attributes[name]
#       else
#         super
#       end
#     end

#     def self.find(id)
#       attributes = @@connection.execute("SELECT * FROM #{table_name} WHERE id = #{id.to_i} LIMIT 1").first
#       new attributes
#     end

#     def self.table_name
#       name.downcase + "s" # => "users"
#     end
#   end
# end