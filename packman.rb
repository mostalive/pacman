require 'test/unit'


PACMANLOOKSUP = 'V'
PACMANWASHERE = ' '

class PacmanTest < Test::Unit::TestCase
    attr_accessor :field, :pacmanRow    
    
    def setup
        self.field = [['.','.','.'],
                  ['.','V','.'],
                  ['.','.','.']]
        self.pacmanRow = 1
    end
    
    def in_field(row, column)
        field[row][column]
    end
    
    def tick
        field[pacmanRow][1] = PACMANWASHERE
        self.pacmanRow -= 1 
        field[pacmanRow][1] = PACMANLOOKSUP
    end

    def test_packman_looks_up_in_center_of_field
        assert_equal PACMANLOOKSUP, in_field(1,1)
    end
    
    def test_packman_moves_up
        tick
        assert_equal PACMANLOOKSUP, in_field(0,1)
        assert_equal PACMANWASHERE, in_field(1,1)
    end
    
    def test_wraps_around_when_at_top
        tick
        tick
        assert_equal PACMANLOOKSUP, in_field(2,1)
        assert_equal PACMANWASHERE, in_field(0,1)
    end
    
end
