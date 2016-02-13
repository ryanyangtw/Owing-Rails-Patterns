require "test_helper"
require 'active_record' # nested bug because of ActiveRecord::Relation
require "relation"


class RelationTest < ActiveSupport::TestCase

  def setup
    @relation = ActiveRecord::Relation.new(User)
  end

  def test_where
    relation = @relation.where("name = 'Marc'")
    assert_equal "SELECT * FROM users WHERE name = 'Marc' AND id = 1", relation.where("id = 1").to_sql
    assert_equal "SELECT * FROM users WHERE name = 'Marc'", relation.to_sql
  end

  def test_order
    relation = @relation.order(:name)
    assert_equal "SELECT * FROM users ORDER BY name", relation.to_sql
  end

  def test_to_a
    user = @relation.where("id = 1").to_a.first
    assert_equal 1, user.id
  end

  def test_proxy_method_calls_to_a
    user = User.where("id = 1").first
    assert_equal 1, user.id
  end

  def test_proxy_class_methods
    sql = User.where("id = 1").search("Marc").to_sql
    assert_equal "SELECT * FROM users WHERE id = 1 AND name LIKE '%Marc%'", sql
  end

end