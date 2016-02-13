module ActiveRecord
  class Relation
    attr_accessor :where_values

    def initialize(klass)
      @klass = klass
      @where_values = []
    end

    # @User.where(...).where(...)
    def where(values)
      relation = clone # self.clone # clone: copy the self object to create a new instance.
      relation.where_values += [values]
      relation
    end

    def to_sql
      sql = "SELECT * FROM #{@klass.table_name}"
      if @where_values.any?
        sql << " WHERE " + @where_values.join(" AND ")
      end
      sql
    end

    def to_a
      # cache the sql
      @record ||= @klass.find_by_sql(to_sql)
    end

    def method_missing(name, *args, &block)
      if @klass.respond_to?(name)
        scoping { @klass.send(name, *args, &block) }
      elsif Array.method_defined?(name)
        to_a.send(name, *args, &block)
      else
        super
      end
    end

    def scoping
      previous = @klass.current_scope
      @klass.current_scope = self # self = relation instance
      yield
    ensure
      @klass.current_scope = previous
    end

  end
end