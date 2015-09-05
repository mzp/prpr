require 'spec_helper'

RSpec.describe Prpr::Event::PullRequestReviewComment do
  let(:payload) { fixture('pull_request_review_comment.json') }

  let(:event) { described_class.new JSON.parse(payload) }

  subject { event }
  it { expect(subject.action).to eq('created') }

  describe '#comment' do
    subject { event.comment }
    it { expect(subject.body).to eq('comment') }
  end
end
