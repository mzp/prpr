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

  it 'returns an error response for the unknown event' do
    headers = { 'HTTP_X_GITHUB_EVENT' => 'unknown' }
    post '/', { payload: '{}' }, headers

    expect(last_response).to be_ok
    expect(last_response.body).to start_with 'Error:'
  end
end
