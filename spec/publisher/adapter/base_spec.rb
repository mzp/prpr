require 'spec_helper'

class TestAdapter < Prpr::Publisher::Adapter::Base
  def publish(message)
  end
end

RSpec.describe Prpr::Publisher::Adapter::Base do
  subject { described_class }

  describe '#adapters' do
    it { expect(subject.adapters).to include(TestAdapter) }
  end

  describe '#broadcast' do
    let(:message) {
      Prpr::Publisher::Message.new from: { login: 'mzp' }, body: 'hello', room: 'general'
    }

    it do
      expect_any_instance_of(TestAdapter).to receive(:publish).with(message)
      subject.broadcast message
    end
  end
end
