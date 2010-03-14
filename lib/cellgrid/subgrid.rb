module CellGrid
  class SubGrid
    attr_reader :start_x, :start_y, :width, :height, :grid
    def initialize(start_x,start_y,width,height,grid)
      @start_x, @start_y = start_x, start_y
      @width, @height = width, height
      @grid = grid
    end
    
    def [](x,y)
      @grid[x+@start_x,y+@start_y]
    end
    
    def each
      (0...@width).each do |x|
        (0...@height).each do |y|
          yield self[x,y]
        end
      end
    end
    
  end
end