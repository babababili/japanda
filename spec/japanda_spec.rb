require 'spec_helper'

describe Japanda do
  it 'isn\'t empty or nil' do
    expect(Japanda::VERSION).to be
  end

  it 'has a version number' do
    expect(Japanda::VERSION).to eql '0.1.4'
  end
end
