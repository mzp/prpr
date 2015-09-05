require 'spec_helper'

RSpec.describe Prpr::Config::Env do
    before { ENV['SOME_VALUE'] = some_value }
  subject { described_class.default }

  describe '#[]' do
    let(:some_value) { 'FOO' }
    it { expect(subject[:some_value]).to eq(some_value) }
  end

  describe '#format' do
    let(:some_value) { '%{name} is good' }
    it { expect(subject.format(:some_value, name: 'foo')).to eq('foo is good') }
    it { expect(subject.format(:some_value, Prpr::Event::PullRequest.new(name: 'foo'))).to eq('foo is good') }

    context 'actual event' do
      let(:some_value) { '' }
      let(:payload) { fixture('pull_request_open.json') }
      let(:event) { Prpr::Event::PullRequest.new JSON.parse(payload) }
      it { expect(subject.format(:some_value, event)).to eq('') }
    end
  end
end
