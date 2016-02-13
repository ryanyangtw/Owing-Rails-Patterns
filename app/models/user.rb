class User < ActiveRecord::Base
  validates :name, presence: true

  # def self.search(name)
  #   where("name LIKE '%#{name}%'")
  # end

  # The same with above
  scope :search, -> name { where("name LIKE '%#{name}%'") }

end


# require "connection_adapter"
# class User
#   @@connection = SqliteAdapter.new

#   def initialize(attributes={})
#     @attributes = attributes
#   end

#   def id
#     @attributes[:id]
#   end

#   def name
#     @attributes[:name]
#   end

#   def self.find(id)
#     attributes = @@connection.execute("SELECT * FROM users WHERE id = #{id.to_i} LIMIT 1").first
#     new attributes # User.new(attributes)
#   end

# end
