require 'test/unit'
require 'mocha'
require 'cellgrid'

class CellTest < Test::Unit::TestCase
  
  def setup
    @klass = Class.new(CellGrid::Cell) do
      has_one :foo, :bar
      has_many :baz, :zot
      has_flag :zing
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
  
  def test_has_ones_are_readable_and_writable
    cell = @klass.new(0,0,@grid)
    assert_nothing_raised { cell.foo = 1 }
    assert_equal 1, cell.foo
  end
  
  def test_has_manys_are_readable_and_arrays
    cell = @klass.new(0,0,@grid)
    assert_equal [], cell.baz
  end
  
  def test_has_manys_are_not_writable
    cell = @klass.new(0,0,@grid)
    assert_raises(NoMethodError) { cell.baz = 1 }
  end
  
  def test_has_flag_can_set_unset_assign_or_test
    cell = @klass.new(0,0,@grid)
    assert_nothing_raised { cell.unset_zing    }
    assert !cell.zing?
    assert_nothing_raised { cell.set_zing      }
    assert cell.zing?
    assert_nothing_raised { cell.zing = "bork" }
    assert_equal true, cell.zing?
  end
  
  def test_splat
    cell = @klass.new(1,2,@grid)
    x,y = *cell
    assert_equal 1, x
    assert_equal 2, y
  end
    
end