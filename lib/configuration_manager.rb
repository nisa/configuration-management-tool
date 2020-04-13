require 'config_parser'
require 'active_support/all'
require 'resource_file'
require 'package'
require 'service'
class ConfigurationManager
  def initialize(config_file:)
    @contents = ConfigParser.new().parse(config_file)
    @applied_resources = []
  end
  
  def execute
    @resources = @contents["resources"]
    @resources.each do |resource|
      resource_class = Object.const_get(resource['resource_type'].classify)
      status = resource_class.new(resource['resource_properties']).apply
      if status 
        @applied_resources.push(resource)
      else
        puts "Could not apply => #{resource['name']}"
        puts "--------------- Rollback in progress ------------------"
        rollback
        break
      end
    end
  end

  def rollback
    @applied_resources.each do |resource|
      resource_class = Object.const_get(resource['resource_type'].classify)
      resource_class.new(resource['resource_properties']).rollback
    end
  end
end