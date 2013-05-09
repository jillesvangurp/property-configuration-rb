# Simple class that loads properties from a file to override a hash with default properties. This is a useful thing to have in any application.
# To use:
# config=PropertiesConfiguration::loadConfiguration({
#   :my_property => 'value'
# },['/etc/localstream/localstream.properties'])
# 
# puts config.my_property
#
module PropertiesConfiguration
  def self.load_properties(properties_filename)
    properties = {}
    if File.exists?(properties_filename)
      File.open(properties_filename, 'r') do | properties_file |
        properties_file.read.each_line do |line|
          line.strip!
          if (line[0] != ?# and line[0] != ?=)
            i = line.index('=')
            if (i)
              properties[line[0..i - 1].strip] = line[i + 1..-1].strip
            else
              properties[line] = ''
            end
          end
        end
      end
    end
    properties
  end

  def self.loadConfiguration(config={}, locations=[])
    hash=config
    if locations
      locations.each do | location |
        properties=load_properties(location)
        hash=hash.merge(properties)
      end
    end
    if java.lang.System
      # only works in jruby
      java.lang.System.getProperties.each do |k,v|
        hash[k]=v
      end
    end

    # create a new class and then return an instance of that class so that we can pretend our properties are actual fields
    Class.new do
      hash.each do |k,v|
        define_method k do
          return v.to_s
        end
      end
    end.new
  end
end
