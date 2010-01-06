require 'test/unit'


PACMANLOOKSUP = 'V'
PACMANLOOKSLEFT = '>'
PACMANLOOKSDOWN = '^'
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
        currentDirection = field[pacmanRow][pacmanColumn]
        field[pacmanRow][pacmanColumn] = PACMANWASHERE
        if currentDirection == PACMANLOOKSUP
            self.pacmanRow -= 1 
            field[pacmanRow][pacmanColumn] = currentDirection
        end
        if currentDirection == PACMANLOOKSLEFT
            self.pacmanColumn -= 1 
            field[pacmanRow][pacmanColumn] = currentDirection
        end        
    end
    
    def left
        field[pacmanRow][1] = PACMANLOOKSLEFT
    end
    
    
    def down
            field[pacmanRow][1] = PACMANLOOKSDOWN
    end
end

class PacmanTest < Test::Unit::TestCase

    attr_accessor :field    
    
    def setup
        self.field = Field.new
    end
    
    def teardown
        assert_exactly_one_packman
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
    
    def test_change_direction_left
        field.left
        assert_equal PACMANLOOKSLEFT, field.in_field(1,1)
    end
    
    
    def test_packman_moves_left
        field.left
        field.tick
        assert_equal PACMANLOOKSLEFT, field.in_field(1,0)
        assert_equal PACMANWASHERE, field.in_field(1,1)
    end

    def test_packman_wraps_around_left
        field.left
        field.tick
        field.tick
        assert_equal PACMANLOOKSLEFT, field.in_field(1,2)
        assert_equal PACMANWASHERE, field.in_field(1,0)
        
        
    end

    def test_change_direction_down
        field.down
        assert_equal PACMANLOOKSDOWN, field.in_field(1,1)
    end
    
    def assert_exactly_one_packman
        count = 0
        field.field.each { |row| 
            row.each { |cell|
                if [ PACMANLOOKSDOWN, PACMANLOOKSLEFT, PACMANLOOKSUP ].include?(cell)
                    count +=1
                end
            }   
        }
        assert_equal count, 1        
    end
end
