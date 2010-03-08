require 'test/unit'
require 'mocha'
require 'cellgrid'

class CellTest < Test::Unit::TestCase
  
  def setup
    @klass = Class.new(CellGrid::Cell) do
      has_one :foo, :bar
    end
    @grid = stub_everything('grid')
  end
  
  def test_cells_must_have_coordinates_and_grid
    assert_raises(ArgumentError) { @klass.new           }
    assert_raises(ArgumentError) { @klass.new(0)        }
    assert_raises(ArgumentError) { @klass.new(0,0)      }
    assert_nothing_raised        { @klass.new(0,0,@grid) }
  end
  
  def test_coordinates_and_grid_are_readable
    cell = @klass.new(1,2,@grid)
    assert_equal 1, cell.x
    assert_equal 2, cell.y
    assert_equal @grid, cell.grid
  end
  
  def test_coordinates_are_not_writable
    cell = @klass.new(1,2,@grid)
    assert_raises(NoMethodError) { cell.x = 0      }
    assert_raises(NoMethodError) { cell.y = 0      }
    assert_raises(NoMethodError) { cell.grid = nil }
  end
  
  def test_cells_get_accessors_based_on_args
    cell = @klass.new(0,0,@grid)
    assert_respond_to cell, :foo
    assert_respond_to cell, :foo=
    assert_respond_to cell, :bar
    assert_respond_to cell, :bar=
  end
  
end