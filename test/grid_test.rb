require 'test/unit'
require 'mocha'
require 'lib/cellgrid'

class GridTest < Test::Unit::TestCase

  def setup
    @cg = CellGrid.new(:foo,:bar)
  end

  def test_grid_requires_width_and_height
    assert_raises(ArgumentError) { @cg::Grid.new        }
    assert_raises(ArgumentError) { @cg::Grid.new(0)     }
    assert_nothing_raised        { @cg::Grid.new(0,0)   }
    assert_raises(ArgumentError) { @cg::Grid.new(0,0,0) }    
  end

  def test_dimensions_are_readable
    grid = @cg::Grid.new(1,2)
    assert_equal 1, grid.width
    assert_equal 2, grid.height
  end
  
  def test_dimensions_are_not_writable
    grid = @cg::Grid.new(1,2)
    assert_raises(NoMethodError) { grid.width  = 0 }
    assert_raises(NoMethodError) { grid.height = 0 }
  end

  def test_grid_access_via_brackets_returns_cells
    grid = @cg::Grid.new(2,2)
    assert_instance_of @cg::Cell, grid[0,0]
  end

  def test_grid_access_restricted_to_dimensions
    grid = @cg::Grid.new(2,2)
    assert_raises(OutOfBoundsError) { grid[4,4] }
  end

end