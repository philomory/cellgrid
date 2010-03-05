require 'cellgrid/errors'
require 'cellgrid/cellclass'
require 'cellgrid/gridclass'
require 'cellgrid/membergrid'

class CellGrid
  # CellGrid works like struct, generating new classes. In this case,
  # CelLGrid creates a module namespacing two classes, Cell and Grid.
  # For details on the Cell and Grid classes, see CellGrid.cell_class and
  # CellGrid.grid_class.
  def self.new(*args)
    mod = Module.new
    mod.const_set(:Cell,CellClass.new(*args))
    mod.const_set(:Grid,GridClass.new(mod,args))
    return mod
  end
  
  protected
  
end