require 'json_schemer'
require 'pry'

class ConfigParser  
  def parse(path)
    contents = JSON.parse(readfile(path))
    validate(contents)
  end

  def readfile(path)
    File.read(path)
    rescue => e
      exit_with_error(e.message)
  end

  def validate(contents)
    schema_file = File.join(File.dirname(__FILE__), "/schema/config_schema.json")
    schema = File.read(schema_file)
    schemer = JSONSchemer.schema(schema)
    schemer.valid?(contents) ? contents : exit_with_error("Invalid configuration file")
  end

  def exit_with_error(message)
    puts message
    exit(1)
  end
end