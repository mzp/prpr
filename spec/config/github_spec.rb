require 'spec_helper'

RSpec.describe Prpr::Config::Github do
  subject { described_class.new('mzp/prpr') }

  describe '#read' do
    let(:github) { double(:github) }
    let(:resource) { double(:resource) }
    let(:content) { 'foo' }

    before do
      allow(Prpr::Repository::Github).to receive(:default).and_return(github)
      allow(resource).to receive(:content).and_return(Base64.encode64(content))
    end

    it do
      expect(github).to receive(:content)
        .with('mzp/prpr', path: 'CONFIG', ref: 'master')
        .and_return(resource)
      expect(subject.read('CONFIG')).to eq(content)
    end
  end
end
