module CellGrid
  
  class Cell
    attr_reader :x, :y, :grid

    def self.has_one(*attrs)
      @has_ones ||= []
      attrs.each do |attribute|
        attr_accessor attribute
        @has_ones << attribute
      end
    end

    def self.has_many(*attrs)
      @has_manys ||= []
      attrs.each do |attribute|
        attr_reader attribute
        @has_manys << attribute
      end
    end
    
    def self.has_flag(*flags)
      @flags ||= []
      flags.each do |flag|
        class_eval %{
          def #{flag}?
            @#{flag}
          end
          def set_#{flag}
            @#{flag} = true
          end
          def unset_#{flag}
            @#{flag} = false
          end
          def #{flag}=(val)
            @#{flag} = !!val
          end
        }
        @flags << flag
      end
    end

    def self.has_ones; @has_ones || []; end
    def self.has_manys; @has_manys || []; end
    def self.flags; @flags || []; end

    def initialize(x,y,grid)
      @x, @y, @grid = x, y, grid
      self.class.has_manys.each do |attribute|
        instance_variable_set("@#{attribute}",[])
      end
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

    def around(radius)
      @grid.around(x,y,radius)
    end

  end
end