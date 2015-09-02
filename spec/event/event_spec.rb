require 'spec_helper'

RSpec.describe Prpr::Event::Event do
 subject { described_class.parse payload, event: event }

  describe '#parse' do
    describe 'pull_requset event' do
      let(:payload) { fixture('pull_request_open.json') }
      let(:event) { 'pull_request' }

      it { expect(subject).to be_kind_of(Prpr::Event::PullRequest) }
      it { expect(subject.action).to eq('opened') }
    end

    describe 'unknown event' do
      let(:payload) { fixture('pull_request_open.json') }
      let(:event) { 'unknown event' }

      it { expect { subject }.to raise_error(Prpr::Event::UnknownEvent) }
    end
  end
end
