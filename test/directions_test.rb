require 'test/unit'
require 'cellgrid'

class DirectionsTest < Test::Unit::TestCase
  def setup
    @cg = CellGrid.new(:foo,:bar)
    @grid = @cg::Grid.new(5,5)
  end
  
  def test_cells_respond_to_cardinal_compass_directions
    cell = @grid[2,2]
    assert_equal @grid[2,1], cell.north
    assert_equal @grid[2,3], cell.south
    assert_equal @grid[3,2], cell.east
    assert_equal @grid[1,2], cell.west
  end
  
  def test_cells_respond_to_personal_directions
    cell = @grid[2,2]
    assert_equal @grid[2,1], cell.up
    assert_equal @grid[2,3], cell.down
    assert_equal @grid[3,2], cell.right
    assert_equal @grid[1,2], cell.left
  end
  
end