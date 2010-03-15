module CellGrid
  
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
      @width.times do |x|
        @height.times do |y|
          yield self[x,y]
        end
      end
    end
    
    def each_sub(sub_width,sub_height)
      if block_given?
        ((width/sub_width.to_f).ceil).times do |sub_x_num|
          ((height/sub_height.to_f).ceil).times do |sub_y_num|
            start_x = sub_x_num * sub_width
            start_y = sub_y_num * sub_height
            yield SubGrid.new(start_x,start_y,sub_width,sub_height,self)
          end
        end
      else
        return Enumerator.new(self,:each_sub,sub_width,sub_height)
      end
    end
    
    def around(x,y,radius)
      positions = []
      (x-radius..x+radius).each do |x_pos|
        if x_pos.between?(0,@width-1)
          remaining = radius - (x - x_pos).abs
          (y-remaining..y+remaining).each do |y_pos|
            if y_pos.between?(0,@height-1)
              positions << self[x_pos,y_pos]
            end
          end
        end
      end
      return positions
    end
    
    def pick(&blk)
      set = self.cells.select(&blk)
      ordered = set.sort_by {rand}
      picked = ordered.first
    end
    
  end
end