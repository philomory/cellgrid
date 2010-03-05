require 'cellgrid/errors'
require 'cellgrid/membergrid'

class CellGrid
  # CellGrid works like struct, generating new classes. In this case,
  # CelLGrid creates a module namespacing two classes, Cell and Grid.
  # For details on the Cell and Grid classes, see CellGrid.cell_class and
  # CellGrid.grid_class.
  def self.new(*args)
    mod = Module.new
    mod.const_set(:Cell,self.cell_class(*args))
    mod.const_set(:Grid,self.grid_class(mod,args))
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
      
      def north
        return @grid[@x,@y-1]
      end
      def south
        return @grid[@x,@y+1]
      end
      def east
        return @grid[@x+1,@y]
      end
      def west
        return @grid[@x-1,@y]
      end
      
      alias_method :up,    :north
      alias_method :down,  :south
      alias_method :right, :east
      alias_method :left,  :west
      
    end
    return cc
  end
  
  # Grids are 2D arrays with defined width and height, holding Cell elements. 
  # They can be iterated over in useful ways (this has not been implimented 
  # yet).
  def self.grid_class(mod,attrs)
    gc = Class.new do
      attr_reader :width, :height
      define_method(:initialize) do |width,height|
        @width, @height = width, height
        @grid_data = Array.new(@width) {|x| Array.new(@height) {|y| mod::Cell.new(x,y,self) } }
      end
      
      def [](x,y)
        if x.between?(0,@width-1) && y.between?(0,@height-1)
          @grid_data[x][y]
        else
          raise OutOfBoundsError, "Coordinates [#{x},#{y}}] are outside the bounds of this Grid."
        end
      end
      
      def cells
        return @grid_data.flatten
      end
      
      attrs.each do |attribute|
        define_method(attribute) do |*args|
          if args.empty?
            return ::CellGrid::MemberGrid.new(self,attribute)
          elsif args.size == 2
            x, y = *args
            self[x,y][attribute]
          else
            raise ArgumentError
          end
        end
      end
      
      def self.forward(*mthds)
        mthds.each do |mthd|
          define_method(mthd) do |x,y|
            self[x,y].send(mthd)
          end
        end
      end
      
    end
    return gc
  end
  
end