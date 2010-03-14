require 'test/unit'
require 'mocha'
require 'cellgrid'

class SubGridTest < Test::Unit::TestCase
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
  
  def test_subgrid_must_have_x_y_h_w_and_grid
    assert_raises(ArgumentError) { CellGrid::SubGrid.new()        }
    assert_raises(ArgumentError) { CellGrid::SubGrid.new(1)       }
    assert_raises(ArgumentError) { CellGrid::SubGrid.new(1,2)     }
    assert_raises(ArgumentError) { CellGrid::SubGrid.new(1,2,3)   }
    assert_raises(ArgumentError) { CellGrid::SubGrid.new(1,2,3,4) }
    assert_nothing_raised { CellGrid::SubGrid.new(1,2,3,4,@grid)  }
  end
  
  def test_all_parameters_are_readable
    sg = CellGrid::SubGrid.new(1,2,3,4,@grid)
    assert_equal 1, sg.start_x
    assert_equal 2, sg.start_y
    assert_equal 3, sg.width
    assert_equal 4, sg.height
    assert_equal @grid, sg.grid
  end
  
  def test_no_parameters_are_writable
    sg = CellGrid::SubGrid.new(1,2,3,4,@grid)
    assert_raises(NoMethodError) { sg.start_x = 0 }
    assert_raises(NoMethodError) { sg.start_y = 0 }
    assert_raises(NoMethodError) { sg.width   = 0 }
    assert_raises(NoMethodError) { sg.height  = 0 }
    assert_raises(NoMethodError) { sg.grid    = 0 }
  end
  
  def test_subgrid_accesses_offset_from_grid
    sg = CellGrid::SubGrid.new(3,3,3,3,@grid)
    assert_equal @grid[3,3], sg[0,0]
    assert_equal @grid[3,5], sg[0,2]
    assert_equal @grid[5,3], sg[2,0]
    assert_equal @grid[5,5], sg[2,2]
  end
  
  def test_subgrid_each
    sg = CellGrid::SubGrid.new(3,3,2,2,@grid)
    @grid.each do |cell|
      if cell.x.between?(3,4) && cell.y.between?(3,4)
        cell.expects(:foo)
      else
        cell.expects(:foo).never
      end 
    end
    sg.each {|cell| cell.foo }
  end
  
end