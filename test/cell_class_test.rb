require 'test/unit'
require 'cellgrid'

class CellClassTest < Test::Unit::TestCase

  def test_cell_class_has_one
    klass = Class.new(CellGrid::Cell) do
      has_one :foo, :bar, :baz
    end
    assert_equal [:foo, :bar, :baz], klass.has_ones
  end
  
  def test_cell_class_has_many
    klass = Class.new(CellGrid::Cell) do
      has_many :foo, :bar, :baz
    end
    assert_equal [:foo, :bar, :baz], klass.has_manys
  end
  
end