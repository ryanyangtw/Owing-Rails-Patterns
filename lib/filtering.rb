require 'active_support/concern'
require 'active_support/callbacks'

module Filtering
  # def self.included(base) # base = ActionController::Base
  #   base.extend ClassMethods
  # end
  extend ActiveSupport::Concern
  include ActiveSupport::Callbacks

  included do
    define_callbacks :process
  end

  module ClassMethods
    def before_action(method)
      set_callback :process, :before, method
      # before_actions << method
    end

    # def before_actions
    #   @before_actions ||= []
    # end

    def after_action(method)
      set_callback :process, :after, method
      # after_actions << method
    end

    # def after_actions
    #   @after_actions ||= []
    # end

    def around_action(method)
      set_callback :process, :around, method
    end
  end

  def process(action_name)
    # self.class.before_actions.each { |method| send method }
    # super
    # self.class.after_actions.each { |method| send method }
    run_callbacks :process do
      super
    end
  end

end