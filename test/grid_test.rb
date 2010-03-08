require 'test/unit'
require 'mocha'
require 'cellgrid'

class GridTest < Test::Unit::TestCase

  def setup
    cell_klass = Class.new(CellGrid::Cell) do
      has_one :foo
    end
    @klass = Class.new(CellGrid::Grid) do
      composed_of cell_klass
    end
    @cell_klass = cell_klass
    @grid = @klass.new(1,2)
  end

  def test_grid_requires_width_and_height
    assert_raises(ArgumentError) { @klass.new        }
    assert_raises(ArgumentError) { @klass.new(0)     }
    assert_nothing_raised        { @klass.new(0,0)   }
    assert_raises(ArgumentError) { @klass.new(0,0,0) }    
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
    assert_instance_of @cell_klass, @grid[0,0]
  end

  def test_grid_access_restricted_to_dimensions
    assert_raises(CellGrid::OutOfBoundsError) { @grid[4,4] }
  end

  def test_grid_cells_returns_flattened_array_of_cells
    cells = @grid.cells
    assert_equal [@grid[0,0],@grid[0,1]], cells
  end

end