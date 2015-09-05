require 'spec_helper'
require 'json'

RSpec.describe Prpr::Event::PullRequest do
  let(:payload) { fixture('pull_request_open.json') }

  let(:event) { described_class.new JSON.parse(payload) }

  subject { event }
  it { expect(subject.action).to eq('opened') }

  describe '#sender' do
    subject { event.sender }
    it { expect(subject.login).to eq('mzp') }
  end

  describe '#to_h' do
    subject { event.sender.to_h }
    it { expect(subject['login']).to eq('mzp') }
  end
end
