require 'service'

describe Service do
  let(:subject) { Service.new( "name": "apache2", "action": "restart", "provider": "service","rollback": "stop")}

  describe 'apply' do
    it 'calls action method' do
      expect(subject).to receive(:restart)
      subject.apply
    end
  end

  describe 'rollback' do
    it 'calls rollback method' do
      expect(subject).to receive(:stop)
      subject.rollback
    end
  end
end