require 'test/unit'
require 'cellgrid'

class GridClassTest < Test::Unit::TestCase

  def test_grid_class_composed_of
    cklass = Class.new(CellGrid::Cell)
    klass = Class.new(CellGrid::Grid) do
      composed_of cklass
    end
    assert_equal cklass, klass.cell_class
  end

end