require 'lib/properties_configuration'

describe 'configuration' do
  it 'should expose defaults' do
    config = PropertiesConfiguration.loadConfiguration({:meaning_of_life => 42})
    config.meaning_of_life.should eq '42'
  end
  
  it 'should respect system properties' do
    if java.lang.System
      java.lang.System.setProperty('meaning_of_life', '42')
      config = PropertiesConfiguration.loadConfiguration({:meaning_of_life => 666})
      config.meaning_of_life.should eq '42'
    else 
      puts 'Java system properties are only accessible in jruby'
    end
  end
  
  it 'should read properties file' do
    config = PropertiesConfiguration.loadConfiguration({:meaning_of_life => 666},[File.dirname(__FILE__)+'/test.properties'])
    config.meaning_of_life.should eq '42'    
  end
end