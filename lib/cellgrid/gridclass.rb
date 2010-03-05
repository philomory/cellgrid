class CellGrid
  class GridClass
    # Grids are 2D arrays with defined width and height, holding Cell elements. 
    # They can be iterated over in useful ways (this has not been implimented 
    # yet).
    def self.new(mod,attrs)
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
end