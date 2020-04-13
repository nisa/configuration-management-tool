require 'configuration_manager'

describe ConfigurationManager do
  example = File.join(File.dirname(__FILE__), 'test-config.json')
  let(:subject) { ConfigurationManager.new(config_file: example) }
  describe 'execute' do
    it 'calls apply on every resource object' do
      expect_any_instance_of(Package).to receive(:apply)
      subject.execute
    end

    context 'when apply fails' do
      it 'calls rollback' do
        expect(subject).to receive(:rollback)
        subject.execute
      end
    end
  end

  describe 'rollback' do
    let(:applied_resources) { 
      { 
        "name" => "install-package",
        "resource_type" => "package",
        "resource_properties" => {
          "name" => "package",
          "provider" => "apt",
          "action" => "install",
          "rollback" => "remove"
        }
      }
    }
    it 'calls rollback on every failed to apply resource object' do
      subject.instance_variable_set(:@applied_resources, [applied_resources])
      expect_any_instance_of(Package).to receive(:rollback)
      subject.rollback
    end
  end
end