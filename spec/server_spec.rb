require 'spec_helper'

RSpec.describe Prpr::Server do
  include Rack::Test::Methods

  def app
    Prpr::Server
  end

  it 'accepts a request for the pull_request event' do
    headers = { 'HTTP_X_GITHUB_EVENT' => 'pull_request' }
    post '/', { payload: '{}' }, headers

    expect(last_response).to be_ok
    expect(last_response.body).to eq 'ok'
  end

  it 'returns an unsupported response for unsupported events' do
    expect_any_instance_of(Logger).not_to receive(:error)

    headers = { 'HTTP_X_GITHUB_EVENT' => 'status' }
    post '/', { payload: '{}' }, headers

    expect(last_response).to be_ok
    expect(last_response.body).to eq 'Unsupported: status'
  end

  it 'returns an error response with error' do
    expect_any_instance_of(Prpr::Runner).to receive(:call).and_raise('test error')

    headers = { 'HTTP_X_GITHUB_EVENT' => 'pull_request' }
    post '/', { payload: '{}' }, headers

    expect(last_response).to be_ok
    expect(last_response.body).to start_with 'Error:'
  end

  def make_signature(token, content)
    'sha1=' + OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha1'), token, content)
  end

  context 'set SECRET_TOKEN' do
    let(:env) { { secret_token: 'secret_token' } }
    before { allow(Prpr::Config::Env).to receive(:default) { env } }

    it 'accepts a request with valid signature' do
      signature = make_signature(env[:secret_token], 'payload=%7B%7D')
      headers = {
        'HTTP_X_GITHUB_EVENT' => 'pull_request',
        'HTTP_X_HUB_SIGNATURE' => signature,
      }
      post '/', { payload: '{}' }, headers

      expect(last_response).to be_ok
      expect(last_response.body).to eq 'ok'
    end

    it 'returns an error response for the invalid request' do
      signature = 'sha1=' + 'A' * 20
      headers = {
        'HTTP_X_GITHUB_EVENT' => 'pull_request',
        'HTTP_X_HUB_SIGNATURE' => signature
      }
      post '/', { payload: '{}' }, headers

      expect(last_response).to be_server_error
      expect(last_response.body).to eq "Signatures didn't match!"
    end
  end
end
