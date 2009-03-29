$:.unshift(File.dirname(__FILE__) + '/../lib')

require 'test/unit'
require 'typed_accessors'

class TypedExample
    float_accessor :dollars
    int_accessor :count
    bool_yn_accessor :onfire
    date_accessor :day
end

class TestTypedAccessors < Test::Unit::TestCase
    def test_float
        t = TypedExample.new

        t.dollars = "54"
        assert_instance_of Float, t.dollars
        assert_equal 54.0, t.dollars

        t.dollars = "54.200000"
        assert_instance_of Float, t.dollars
        assert_equal 54.2, t.dollars
        
        t.dollars = 54
        assert_instance_of Float, t.dollars
        assert_equal 54.0, t.dollars
    end

    def test_int
        t = TypedExample.new

        t.count = "54"
        assert_instance_of Fixnum, t.count
        assert_equal 54, t.count

        t.count = "54.200000"
        assert_instance_of Fixnum, t.count
        assert_equal 54, t.count
        
        t.count = 54.0
        assert_instance_of Fixnum, t.count
        assert_equal 54, t.count
    end

    def test_bool
        t = TypedExample.new

        t.onfire = "Y"
        assert_instance_of TrueClass, t.onfire
        assert_equal true, t.onfire

        t.onfire = "54.200000"
        assert_instance_of FalseClass, t.onfire
        assert_equal false, t.onfire
        
        t.onfire = "y"
        assert_instance_of TrueClass, t.onfire
        assert_equal true, t.onfire

        t.onfire = false
        assert_instance_of FalseClass, t.onfire
        assert_equal false, t.onfire

        t.onfire = true
        assert_instance_of TrueClass, t.onfire
        assert_equal true, t.onfire
    end
end

