require 'core_ext'

# Add our framework code to the load path.
# We prepand the path to the beginner of the array. 
# Make sure it will look for those path first before loot for gems
$LOAD_PATH.unshift "app/controllers", "app/models", "config"


class Object
  def self.const_missing(name)
    # :ApplicationController => application_controller
    file_name = name.to_s.underscore
    require file_name
    const_get name # :ApplicationController => ApplicationController
    # super
  end
end