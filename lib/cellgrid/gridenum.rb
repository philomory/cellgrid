require 'cellgrid/pickable'

module CellGrid
  module GridEnum
    include Enumerable
    include Pickable
    
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
    
  end
end