require 'class_init'
class Service
  include ClassInit
  attr_accessor :name, :action, :provider, :rollback

  def apply
    self.send(@action.to_sym) 
  end

  def rollback
    self.send(@rollback.to_sym)
  end

  private

  def start
    system("service #{@name} start") if @provider == 'service'
  end

  def stop
    system("service #{@name} stop") if @provider == 'service'
  end

  def restart
    system("service #{@name} restart") if @provider == 'service'
  end
end