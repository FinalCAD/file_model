require 'spec_helper'

RSpec.describe FileModel::Configuration do

  it do
    expect(subject.store).to eql(:memory)
  end
end
