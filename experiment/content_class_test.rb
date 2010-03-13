require 'test/unit'
require 'cellgrid'

class ContentClassTest < Test::Unit::TestCase
  
  def setup

  end
  
  def test_content_class_fills
    cell_klass = Class.new(CellGrid::Cell) do
      has_one :foo
    end
    content_klass = Class.new(CellGrid::Content) do
      fills :foo
    end
    
    assert_equal :foo, content_klass.slot
  end
  
  
end