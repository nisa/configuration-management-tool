require 'package'

describe Package do
  let(:subject) { Package.new({'name': 'package', 'provider': 'apt', 'action': 'install', 'rollback': 'remove' })}

  describe 'apply' do
    it 'calls action method' do
      expect(subject).to receive(:install)
      subject.apply
    end
  end

  describe 'rollback' do
    it 'calls rollback method' do
      expect(subject).to receive(:remove)
      subject.rollback
    end
  end
end