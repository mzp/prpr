require 'spec_helper'

RSpec.describe Prpr::Config::Github do
  subject { described_class.new('mzp/prpr') }

  describe '#read' do
    before {
      stub_request(:get, 'https://github.com/mzp/prpr/raw/master/CONFIG').to_return(body: 'some config')
    }
    it { expect(subject.read('CONFIG')).to eq('some config') }
  end
end
