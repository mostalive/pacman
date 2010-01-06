require 'test/unit'


PACMANLOOKSUP = 'V'
PACMANLOOKSLEFT = '>'
PACMANWASHERE = ' '

class Field
    attr_accessor :field, :pacmanColumn, :pacmanRow    

    def initialize
        self.field = [['.','.','.'],
                      ['.','V','.'],
                      ['.','.','.']]
        self.pacmanRow = 1
        self.pacmanColumn = 1
    end
    
    def in_field(row, column)
        field[row][column]
    end
    
    def tick
        
        if field[pacmanRow][pacmanColumn] == PACMANLOOKSUP
            field[pacmanRow][pacmanColumn] = PACMANWASHERE
            self.pacmanRow -= 1 
            field[pacmanRow][pacmanColumn] = PACMANLOOKSUP
        end
        
        if field[pacmanRow][pacmanColumn] == PACMANLOOKSLEFT
            field[pacmanRow][pacmanColumn] = PACMANWASHERE
            self.pacmanColumn -= 1 
            field[pacmanRow][pacmanColumn] = PACMANLOOKSLEFT
        end
        
    end
    
    def left
        field[pacmanRow][1] = PACMANLOOKSLEFT
    end
end

class PacmanTest < Test::Unit::TestCase

    attr_accessor :field    
    
    def setup
        self.field = Field.new
    end
    
    def test_packman_looks_up_in_center_of_field
        assert_equal PACMANLOOKSUP, field.in_field(1,1)
    end
    
    def test_packman_moves_up
        field.tick
        assert_equal PACMANLOOKSUP, field.in_field(0,1)
        assert_equal PACMANWASHERE, field.in_field(1,1)
    end
    
    def test_wraps_around_when_at_top
        field.tick
        field.tick
        assert_equal PACMANLOOKSUP, field.in_field(2,1)
        assert_equal PACMANWASHERE, field.in_field(0,1)
    end
    
    def test_change_direction
        field.left
        assert_equal PACMANLOOKSLEFT, field.in_field(1,1)
    end
    
    
    def test_packman_moves_left
        field.left
        field.tick
        assert_equal PACMANLOOKSLEFT, field.in_field(1,0)
        assert_equal PACMANWASHERE, field.in_field(1,1)
    end
end
