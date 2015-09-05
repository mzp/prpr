require 'spec_helper'
require 'json'

RSpec.describe Prpr::Event::Push do
  let(:payload) { fixture('push.json') }

  let(:event) { described_class.new JSON.parse(payload) }

  subject { event }
  it { expect(subject.created).to be_falsy }

  describe '#sender' do
    subject { event.sender }
    it { expect(subject.login).to eq('mzp') }
  end
end
