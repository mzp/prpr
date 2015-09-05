require 'spec_helper'

RSpec.describe Prpr::Event::CommitComment do
  let(:payload) { fixture('commit_comment.json') }

  let(:event) { described_class.new JSON.parse(payload) }

  subject { event }
  it { expect(subject.action).to eq('created') }

  describe '#comment' do
    subject { event.comment }
    it { expect(subject.body).to eq('bbb') }
  end
end
