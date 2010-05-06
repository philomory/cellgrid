require 'cellgrid/gridenum'

module CellGrid
  
  # Grids are 2D arrays with defined width and height, holding Cell elements. 
  # They can be iterated over in useful ways (this has not been implimented 
  # yet).
  class Grid
    include GridEnum
    
    def self.composed_of(cell_class)
      @cell_class = cell_class
    end
    
    def self.cell_class
      @cell_class
    end
    
    attr_reader :width, :height
    def initialize(width,height,&blk)
      @width, @height = width, height
      cc = self.class.cell_class
      @grid_data = Array.new(@width) {|x| Array.new(@height) {|y| cc.new(x,y,self)}}
      if blk
        self.each(&blk)
      end
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
    
    def each
      if block_given?
        width.times do |x|
          height.times do |y|
            yield self[x,y]
          end
        end
      else
        return Enumerator.new(self,:each)
      end
    end
    
  end
end