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
    @sg = CellGrid::SubGrid.new(2,2,3,3,@grid)
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
  
  def test_subgrid_around_with_coords
    around = @sg.around(1,1,1)
    g = @grid
    expected = Set.new([
                    g[3,2],
            g[2,3], g[3,3], g[4,3],
                    g[3,4]
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
  
  def test_subgrid_around_with_cell
    around = @sg[1,1].around(1)
    g = @grid
    expected = Set.new([
                    g[3,2],
            g[2,3], g[3,3], g[4,3],
                    g[3,4]
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

  def test_each_sub
    @grid.each {|cell| cell.expects(:foo) }
    @grid.each_sub(4,4) do |sub|
      sub.each {|cell| cell.foo }
    end
  end
  
  def test_each_sub_in_sub
    @grid.each {|cell| cell.expects(:foo)}
    @grid.each_sub(4,4) do |sub|
      sub.each_sub(3,3) do |subsub|
        subsub.each {|cell| cell.foo }
      end
    end
  end
  
  def test_each_sub_without_block
    enum = @grid.each_sub(4,4)
    assert_instance_of Enumerator, enum
    
    @grid.each {|cell| cell.expects(:foo) }
    enum.each do |sub|
      sub.each {|cell| cell.foo }
    end
  end
  
  def test_pick_single
    @grid.each do |cell|
      cell.foo = cell.x + cell.y
    end
    picked = @grid.pick {|cell| cell.foo.even? }
    assert_kind_of CellGrid::Cell, picked
    assert picked.foo.even?
  end
  
  def test_pick_single_in_sub
    @grid.each do |cell|
      cell.foo = cell.x + cell.y
    end
    picked = @sg.pick {|cell| cell.foo.even? }
    assert picked.foo.even?
    assert picked.x.between?(2,5)
    assert picked.y.between?(2,5)
  end
  
  
  def test_pick_multiple
    @grid.each do |cell|
      cell.foo = cell.x + cell.y
    end
    picked = @grid.pick(4) {|cell| cell.foo.even? }
    assert_instance_of Array, picked
    assert_equal 4, picked.length
    picked.each do |pick|
      assert pick.foo.even?
    end
  end

  def test_multiple_not_enough
    @grid.each do |cell|
      cell.foo = cell.x + cell.y
    end
    picked = @grid.pick(6) {|cell| cell.foo.even? && cell.x.zero? }
    assert_instance_of Array, picked
    assert_equal 5, picked.length
    picked.each do |pick|
      assert pick.foo.even?
      assert_equal 0, pick.x
    end
  end

  def test_pick_single_with_rng
    rng = mock('rng')
    rng.expects(:call).returns(3)
    @grid.each do |cell|
      cell.foo = cell.x + cell.y
    end
    picked = @grid.pick(nil,rng) {|cell| cell.foo.even? }
  end
  
  def test_pick_multiple_with_rng
    rng = mock('rng')
    rng.expects(:call).times(5).returns(3,2,1,4,5)
    @grid.each do |cell|
      cell.foo = cell.x + cell.y
    end
    picked = @grid.pick(5,rng) {|cell| cell.foo.even? && cell.x.zero? }
  end

end