require 'class_init'
class ResourceFile
  include ClassInit
  attr_accessor :name, :path, :mode, :group, :content, :owner, :action, :rename_as, :rollback

  def apply
    self.send(@action.to_sym) 
  end

  def rollback
    self.send(@rollback.to_sym)
  end

  private

  def create
    File.exist?("#{@path}/#{@name}") ? true : save_file if precheck
  end

  def update
    File.exist?("#{@path}/#{@name}") ? true : save_file if precheck
  end

  def delete
    File.exist?("#{@path}/#{@name}") ? File.delete("#{@path}/#{@name}") : true
  end

  def precheck
    Dir.exist?(@path) ? true : false
  end

  def save_file
    f = @action == 'update' ? File.open("#{@path}/#{@name}", 'w') : File.new("#{@path}/#{@name}", 'w')
    content_file = File.join(File.dirname(__FILE__), "/data/#{@content}")
    if content_file && @content
      data = File.read(content_file)
      f.write(data)
    end
    f.close
    FileUtils.chown @owner, @group, "#{@path}/#{@name}"
  end
end