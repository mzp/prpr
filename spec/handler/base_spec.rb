require 'spec_helper'

class TestHandler < Prpr::Handler::Base
  handle Prpr::Event::PullRequest, action: /opened/, number: 26 do
    self.invoked(event)
  end

  handle Prpr::Event::PullRequest, action: 'labeled', number: 26 do
    self.invoked(event)
  end

  def invoked(_)
  end
end

RSpec.describe Prpr::Handler::Base do
  let(:json) {
    JSON.parse fixture('pull_request_open.json')
  }

  let(:event) {
    Prpr::Event::PullRequest.new(payload)
  }

  describe '#query' do
    describe '/regexp/' do
      context 'matched' do
        let(:payload) { json }

        it do
          expect_any_instance_of(TestHandler).to receive(:invoked).with(event)
          Prpr::Handler::Base.on_event event
        end
      end

      context 'unmatch' do
        let(:payload) { json.merge action: 'closed' }

        it do
          expect_any_instance_of(TestHandler).to_not receive(:invoked)
          Prpr::Handler::Base.on_event event
        end
      end
    end

    describe '"string"' do
      context 'matched' do
        let(:payload) { json.merge action: 'labeled' }

        it do
          expect_any_instance_of(TestHandler).to receive(:invoked).with(event)
          Prpr::Handler::Base.on_event event
        end
      end

      context 'unmatch' do
        let(:payload) { json.merge action: 'unlabeled' }

        it do
          expect_any_instance_of(TestHandler).to_not receive(:invoked)
          Prpr::Handler::Base.on_event event
        end
      end
    end
  end
end
