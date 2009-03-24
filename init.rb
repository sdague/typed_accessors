class Class
    def bool_yn_accessor( *symbols )
        attr_reader( *symbols )
        bool_yn_writer( *symbols )
    end

    def float_accessor( *symbols )
        attr_reader( *symbols )
        float_writer( *symbols )
    end
    
    def int_accessor( *symbols )
        attr_reader( *symbols )
        int_writer( *symbols )
    end
    
    def date_accessor( *symbols )
        attr_reader( *symbols )
        date_writer( *symbols )
    end

    private
    
    def date_writer( *symbols )
        symbols.each do |symbol|
            class_eval(<<-EOS, __FILE__, __LINE__)
                def #{symbol}=(val)
                    if val.class.to_s == 'String'
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
                    if val.upcase == 'Y' || val == true then
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
