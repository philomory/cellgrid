require 'test/unit'
require 'mocha'
require 'cellgrid'

class GridTest < Test::Unit::TestCase

  def setup
    @cg = CellGrid.new(:foo,:bar)
    @grid = @cg::Grid.new(1,2)
  end

  def test_grid_requires_width_and_height
    assert_raises(ArgumentError) { @cg::Grid.new        }
    assert_raises(ArgumentError) { @cg::Grid.new(0)     }
    assert_nothing_raised        { @cg::Grid.new(0,0)   }
    assert_raises(ArgumentError) { @cg::Grid.new(0,0,0) }    
  end

  def test_dimensions_are_readable
    assert_equal 1, @grid.width
    assert_equal 2, @grid.height
  end
  
  def test_dimensions_are_not_writable
    assert_raises(NoMethodError) { @grid.width  = 0 }
    assert_raises(NoMethodError) { @grid.height = 0 }
  end

  def test_grid_access_via_brackets_returns_cells
    assert_instance_of @cg::Cell, @grid[0,0]
  end

  def test_grid_access_restricted_to_dimensions
    assert_raises(CellGrid::OutOfBoundsError) { @grid[4,4] }
  end

  def test_grid_cells_returns_flattened_array_of_cells
    cells = @grid.cells
    assert_equal [@grid[0,0],@grid[0,1]], cells
  end
  
  def test_forwarding_accessors_to_cells
    @grid[0,0].foo = "bar"
    assert_equal "bar", @grid.foo(0,0)
  end
  
  def test_forwarding_declared_messages_to_cells
    @cg::Grid.forward :zing
    @grid[0,0].expects(:zing)
    @grid.zing(0,0)
  end

end