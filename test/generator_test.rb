require 'test/unit'
require 'cellgrid'

class GeneratorTest < Test::Unit::TestCase
  
  def test_should_create_container_module
    cg = CellGrid.new(:foo)
    assert_instance_of Module, cg
  end
  
  def test_should_create_cell_class_in_container
    cg = CellGrid.new(:foo)
    assert_instance_of Class, cg::Cell 
  end
  
  def test_should_create_grid_class_in_container
    cg = CellGrid.new(:foo)
    assert_instance_of Class, cg::Grid
  end
  
  #def test_should_accept_existing_module_as_container
  #  mod = Module.new
  #  cg = CellGrid.new(mod)
  #  assert_equal mod, cg
  #end  
  
end