require 'test/unit'


PACMANLOOKSUP = 'V'

class PacmanTest < Test::Unit::TestCase
    def in_field(row, column)
        PACMANLOOKSUP
    end

    def test_packman_looks_up_in_center_of_field
        assert_equal PACMANLOOKSUP, in_field(1,1)
    end
end
