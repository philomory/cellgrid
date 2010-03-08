class CellGrid
  
  # Grids are 2D arrays with defined width and height, holding Cell elements. 
  # They can be iterated over in useful ways (this has not been implimented 
  # yet).
  class Grid
    
    def self.composed_of(cell_class)
      @cell_class = cell_class
    end
    
    def self.cell_class
      @cell_class
    end
    
    attr_reader :width, :height
    def initialize(width,height)
      @width, @height = width, height
      cc = self.class.cell_class
      @grid_data = Array.new(@width) {|x| Array.new(@height) {|y| cc.new(x,y,self)}}
    end
    
    def [](x,y)
      if x.between?(0,@width-1) && y.between?(0,@height-1)
        @grid_data[x][y]
      else
        raise OutOfBoundsError, "Coordinates [#{x},#{y}}] are outside the bounds of this Grid."
      end
    end
    
    def cells
      @grid_data.flatten
    end
    
  end
end