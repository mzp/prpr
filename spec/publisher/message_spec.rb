require 'spec_helper'

RSpec.describe Prpr::Publisher::Message do
  subject {
    described_class.new from: { login: 'mzp' }, body: 'hello', room: 'general'
  }

  it { expect(subject.from.login).to eq('mzp') }
  it { expect(subject.body).to eq('hello') }
  it { expect(subject.room).to eq('general') }
end
