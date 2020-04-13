require 'resource_file'

describe ResourceFile do
  let(:subject) { ResourceFile.new( 
                                    "name": "index.php",
                                    "owner": "root", 
                                    "path": "/var/www/html",
                                    "content": "hello.php", 
                                    "action": "create",
                                    "rollback": "delete"
                                    )}

  describe 'apply' do
    it 'calls action method' do
      expect(subject).to receive(:create)
      subject.apply
    end
  end

  describe 'rollback' do
    it 'calls rollback method' do
      expect(subject).to receive(:delete)
      subject.rollback
    end
  end
end