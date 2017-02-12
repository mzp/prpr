require 'spec_helper'

RSpec.describe Prpr::Webhook do
  describe '#create_or_update' do
    let(:repo) { 'mzp/prpr' }
    let(:url) { 'http://prpr.example.com' }
    let(:webhook) { Prpr::Webhook.new(repo, url) }

    context 'initialize with invalid args' do
      subject { Prpr::Webhook.new(nil, nil).create_or_update }
      it { expect { subject }.to raise_error Prpr::Webhook::MSG }
    end

    shared_context 'stub Webhooks API' do
      let(:env) { { secret_token: 'secret_token' } }
      let(:client) { instance_double(Octokit::Client, hooks: [], create_hook: nil, edit_hook: nil) }

      before do
        allow(hook).to receive_message_chain(:config, :url).and_return(url)
        allow(Prpr::Config::Env).to receive(:default) { env }
        allow(webhook).to receive(:client) { client }
      end
    end

    context 'a hook has already saved' do
      include_context 'stub Webhooks API'

      let(:hook) { double('hook', id: 1) }

      before do
        allow(client).to receive(:hooks).and_return([hook])
        allow(client).to receive(:edit_hook).and_return(hook)
      end

      it 'update a hook' do
        expect(webhook.create_or_update).to eq hook

        expect(client).to have_received(:hooks).with(repo)
        expect(client).to have_received(:edit_hook).with(
          repo,
          hook.id,
          'web',
          { url: url, secret: env[:secret_token] },
          events: Prpr::Webhook::EVENTS)
      end
    end

    context 'a hook not exist' do
      include_context 'stub Webhooks API'

      let(:hook) { double('hook') }

      before { allow(client).to receive(:create_hook).and_return(hook) }

      it 'create a hook' do
        expect(webhook.create_or_update).to eq hook

        expect(client).to have_received(:hooks).with(repo)
        expect(client).to have_received(:create_hook).with(
          repo,
          'web',
          { url: url, secret: env[:secret_token] },
          events: Prpr::Webhook::EVENTS)
      end
    end
  end
end
