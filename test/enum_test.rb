require 'test/unit'
require 'set'
require 'cellgrid'

class CellGrid::Cell
  def inspect
    "<Cell[#{x},#{y}]>"
  end
end

class EnumTest < Test::Unit::TestCase
  def setup
    cell_klass = Class.new(CellGrid::Cell) do
      has_one :foo
    end
    @klass = Class.new(CellGrid::Grid) do
      composed_of cell_klass
    end
    @cell_klass = cell_klass
    @grid = @klass.new(10,10)
  end
  
  def test_around_with_coords
    around = @grid.around(5,5,2)
    g = @grid
    expected = Set.new([
                        g[5,3],
                g[4,4], g[5,4], g[6,4],
        g[3,5], g[4,5], g[5,5], g[6,5], g[7,5],
                g[4,6], g[5,6], g[6,6],
                        g[5,7]
                        ])
    assert_equal expected, Set.new(around)
  end
  
  def test_around_with_cell
    around = @grid[5,5].around(2)
    g = @grid
    expected = Set.new([
                        g[5,3],
                g[4,4], g[5,4], g[6,4],
        g[3,5], g[4,5], g[5,5], g[6,5], g[7,5],
                g[4,6], g[5,6], g[6,6],
                        g[5,7]
                        ])
    assert_equal expected, Set.new(around)
  end
  
  def test_each
    (0...@grid.width).each do |x|
      (0...@grid.height).each do |y|
        @grid[x,y].expects(:hello)
      end
    end
    @grid.each {|cell| cell.hello }
  end
  
  def test_pick_single
    @grid.each do |cell|
      cell.foo = cell.x + cell.y
    end
    picked = @grid.pick {|cell| cell.foo.even? }
    assert_kind_of CellGrid::Cell, picked
    assert picked.foo.even?
  end
  
end