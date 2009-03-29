# Typed accessors works as a Mixin on Class.  It creates a set of
# functions that are used in the class definition which eval and
# create new accessor methods at class eval time (so little
# performance penalty).  For now, this is limitted to built in types,
# float, int, boolean, and date, though this approach could clearly be
# expanded.
#
# Example of a class definition
#
#   class MyClass
#     float_accessor :distance
#     int_accessor :count
#     bool_yn_accessor :onfire?
#     date_accessor :day
#   end

class Class
    
    # Creates a boolean accessor.  It will convert and incoming string
    # to a true / false value.  If the string is "y" or "Y" it will be
    # true, otherwise false.
    def bool_yn_accessor( *symbols )
        attr_reader( *symbols )
        bool_yn_writer( *symbols )
    end

    
    # Creates a float accessor, using built in .to_f functions on
    # objects.  Any object that has a .to_f is supported.
    def float_accessor( *symbols )
        attr_reader( *symbols )
        float_writer( *symbols )
    end
    
    # Creates an int accessor, using built in .to_i functions on
    # objects.  Any object that has a .to_i is supported.
    def int_accessor( *symbols )
        attr_reader( *symbols )
        int_writer( *symbols )
    end
    
    # Creates a data accessor using the Date parse function on
    # strings.  Not defined for other input types.
    def date_accessor( *symbols )
        attr_reader( *symbols )
        date_writer( *symbols )
    end

    private
    
    def date_writer( *symbols )
        symbols.each do |symbol|
            class_eval(<<-EOS, __FILE__, __LINE__)
                def #{symbol}=(val)
                    if val.is_a? String
                        instance_variable_set("@#{symbol}", Date.parse(val))
                    else
                        instance_variable_set("@#{symbol}", val)
                    end
                end
            EOS
        end
    end
    
    def bool_yn_writer( *symbols )
        symbols.each do |symbol|
            class_eval(<<-EOS, __FILE__, __LINE__)
                def #{symbol}=(val)
                    if (val.is_a? String and val.upcase == 'Y') or val == true then
                        instance_variable_set("@#{symbol}", true)
                    else
                        instance_variable_set("@#{symbol}", false)
                    end
                end
            EOS
        end
    end
        
    def float_writer( *symbols )
        symbols.each do |symbol|
            class_eval(<<-EOS, __FILE__, __LINE__)
                def #{symbol}=(val)
                    if !val.respond_to?('to_f') then raise ArgumentError, "#{symbol} must be Float" end
                    instance_variable_set("@#{symbol}", val.to_f)
                end
            EOS
        end
    end

    def int_writer( *symbols )
        symbols.each do |symbol|
            class_eval(<<-EOS, __FILE__, __LINE__)
                def #{symbol}=(val)
                    if !val.respond_to?('to_i') then raise ArgumentError, "#{symbol} must be Integer" end
                    instance_variable_set("@#{symbol}", val.to_i)
                end
            EOS
        end
    end
end
