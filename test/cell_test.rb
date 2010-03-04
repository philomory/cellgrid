require 'test/unit'
require 'mocha'
require 'lib/cellgrid'

class CellTest < Test::Unit::TestCase
  
  def setup
    @cg = CellGrid.new(:foo,:bar)
    @grid = stub_everything('grid')
  end
  
  def test_cells_must_have_coordinates_and_grid

    assert_raises(ArgumentError) { @cg::Cell.new           }
    assert_raises(ArgumentError) { @cg::Cell.new(0)        }
    assert_raises(ArgumentError) { @cg::Cell.new(0,0)      }
    assert_nothing_raised        { @cg::Cell.new(0,0,@grid) }
  end
  
  def test_cells_get_accessors_based_on_args
    cell = @cg::Cell.new(0,0,@grid)
    assert_respond_to cell, :foo
    assert_respond_to cell, :foo=
    assert_respond_to cell, :bar
    assert_respond_to cell, :bar=
  end
  

  
  
end