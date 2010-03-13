require 'test/unit'
require 'cellgrid'

class ContentTest < Test::Unit::TestCase
  
  def setup
    @cell_klass = cell_klass = Class.new(CellGrid::Cell) do
      has_one  :foo, :bar
      has_many :baz
    end
    grid_klass = Class.new(CellGrid::Grid) { composed_of cell_klass }
    @foo_class = Class.new(CellGrid::Content) { fills :foo, cell_klass }
    @bar_class = Class.new(CellGrid::Content) { fills :bar, cell_klass }
    @baz_class = Class.new(CellGrid::Content) { fills :baz, cell_klass }
    @grid = grid_klass.new(5,5)
    @cell = @grid[2,2]
  end
  
  def test_cell_is_readable
  end
  
  
end