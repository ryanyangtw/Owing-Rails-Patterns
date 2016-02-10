require 'filtering'

module ActionController
  class Metal
    attr_accessor :request, :response

    def process(action_name)
      send action_name # index
    end
  end

  class Base < Metal
    # extend Filtering  # => Using extend to add class method
    # method in Filtering can overwrite the mehod in Metal
    include Filtering
    # def self.before_action(method)
    # end
  end
end