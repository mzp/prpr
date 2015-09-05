require 'spec_helper'

RSpec.describe Prpr::Event::Event do
 subject { described_class.parse payload, event: event }

  describe '#parse' do
    describe 'pull_requset event' do
      context 'pull request' do
        let(:payload) { fixture('pull_request_open.json') }
        let(:event) { 'pull_request' }

        it { expect(subject).to be_kind_of(Prpr::Event::PullRequest) }
      end

      context 'push' do
        let(:payload) { fixture('push.json') }
        let(:event) { 'push' }

        it { expect(subject).to be_kind_of(Prpr::Event::Push) }
      end

      context 'issue_comment' do
        let(:payload) { fixture('issue_comment.json') }
        let(:event) { 'issue_comment' }

        it { expect(subject).to be_kind_of(Prpr::Event::IssueComment) }
      end

      context 'commit_comment' do
        let(:payload) { fixture('commit_comment.json') }
        let(:event) { 'commit_comment' }

        it { expect(subject).to be_kind_of(Prpr::Event::CommitComment) }
      end

      context 'pull_request_review_comment' do
        let(:payload) { fixture('pull_request_review_comment.json') }
        let(:event) { 'pull_request_review_comment' }

        it { expect(subject).to be_kind_of(Prpr::Event::PullRequestReviewComment) }
      end
    end

    describe 'unknown event' do
      let(:payload) { fixture('pull_request_open.json') }
      let(:event) { 'unknown event' }

      it { expect { subject }.to raise_error(Prpr::Event::UnknownEvent) }
    end
  end
end
