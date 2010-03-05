require 'test/unit'
require 'mocha'
require 'cellgrid'

class MemberGridTest < Test::Unit::TestCase

  def setup
    @cg = CellGrid.new(:foo,:bar)
    @grid = @cg::Grid.new(1,2)
    @member_grid = @grid.foo
  end
  
  def test_member_accesor_without_coordinates_returns_member_grid
    assert_instance_of CellGrid::MemberGrid, @member_grid
  end
  
  def test_grid_and_member_are_readable
    assert_equal @grid, @member_grid.grid
    assert_equal :foo, @member_grid.member
  end
  
  def test_grid_and_member_are_not_writable
    assert_raises(NoMethodError) { @member_grid.grid   = nil }
    assert_raises(NoMethodError) { @member_grid.member = nil }
  end
  
  def test_member_grid_access_by_brackets_returns_member_of_requested_cell
    assert_equal @grid[0,0].foo, @member_grid[0,0]
  end
  
  def test_member_grid_bracket_access_allows_writing
    @member_grid[0,0] = "bar"
    assert_equal "bar", @grid[0,0].foo
  end
  
end