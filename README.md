# properties-configuration-rb

Simple solution that allows you to define properties in code and override them using properties files. The default values are defined in your ruby code
as a simple hash. You access the properties via members of the config object.

Combining this project with my [DIY dependency injection](https://github.com/jillesvangurp/diy-dependency-injection-rb) project or something similar is a good way to manage application wide configuration in an easy way. I use this as part of my application definition module and inject the configuration wherever I need it.

# Install
    gem install properties-configuration

# Usage

    require 'properties_configuration'
    
    config=PropertiesConfiguration::loadConfiguration({
      :my_property => 'value'
    },['/etc/my.properties', '/etc/more.properties'])
    
    puts config.my_property

# License

This code is licensed under the expat license. See the LICENSE file for details.
