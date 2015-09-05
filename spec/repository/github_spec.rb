require 'spec_helper'

RSpec.describe Prpr::Repository::Github do
  describe '#new' do
    before do
      ENV['GITHUB_ACCESS_TOKEN'] = 'foo'
    end

    context 'default host' do
      before do
        ENV['GITHUB_HOST'] = nil
      end

      it do
        expect(Octokit::Client).to receive(:new).with(
          access_token: 'foo')
        described_class.default
      end
    end

    context 'custom host' do
      before do
        ENV['GITHUB_HOST'] = 'example.com'
      end

      it do
        expect(Octokit::Client).to receive(:new).with(
          access_token: 'foo',
          web_endpoint: 'https://example.com/',
          api_endpoint: 'https://example.com/api/v3')
        described_class.default
      end
    end
  end
end
