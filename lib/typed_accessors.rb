$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require "typed_accessors/class.rb"

module TypedAccessors
    VERSION = '0.3.0'
end
