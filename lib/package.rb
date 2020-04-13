require 'class_init'
class Package
  include ClassInit
  attr_accessor :name, :provider, :action, :rollback

  def apply
    self.send(@action.to_sym) 
  end

  def rollback
    self.send(@rollback.to_sym)
  end

  private

  def install
    return system("apt install #{@name}") if @provider == 'apt'
  end

  def remove
    return system("apt remove #{@name}") if @provider == 'apt'
  end
end