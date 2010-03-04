class CellGrid
  # CellGrid works like struct, generating new classes. In this case,
  # CelLGrid creates a module namespacing two classes, Cell and Grid.
  # For details on the Cell and Grid classes, see CellGrid.cell_class and
  # CellGrid.grid_class.
  def self.new(*args)
    mod = Module.new
    mod.const_set(:Cell,self.cell_class(*args))
    mod.const_set(:Grid,self.grid_class)
    return mod
  end
  
  protected
  
  # Cells are structs with members based on the arguments to CellGrid.new,
  # with additional readers x, y and grid whose values are set
  # based on the arguments to Cell.new.
  def self.cell_class(*args)
    cc = Struct.new(*args) do
      attr_reader :x, :y, :grid
      def initialize(x,y,grid)
        @x, @y, @grid = x, y, grid
      end
    end
    return cc
  end
  
  # Grids are 2D arrays with defined width and height, holding Cell elements. 
  # They can be iterated over in useful ways (this has not been implimented 
  # yet).
  def self.grid_class
    gc = Class.new do
      attr_reader :width, :height
      def initialize(width,height)
        @width, @height = width, height 
      end
    end
    return gc
  end
  
end