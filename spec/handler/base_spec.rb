require 'spec_helper'

class TestHandler < Prpr::Handler::Base
  handle Prpr::Event::PullRequest, action: /opened/, number: 26 do
    self.invoked(event)
  end

  def invoked(_)
  end
end

RSpec.describe Prpr::Handler::Base do
  let(:json) {
    JSON.parse fixture('pull_request_open.json')
  }

  context 'invoke matched handler' do
    let(:event) {
      Prpr::Event::PullRequest.new(json)
    }

    it do
      expect_any_instance_of(TestHandler).to receive(:invoked).with(event)
      Prpr::Handler::Base.on_event event
    end
  end

  context 'not invoke un-matched handler' do
    let(:event) {
      Prpr::Event::PullRequest.new(json.merge(action: 'closed'))
    }

    it do
      expect_any_instance_of(TestHandler).to_not receive(:invoked)
      Prpr::Handler::Base.on_event event
    end
  end
end
