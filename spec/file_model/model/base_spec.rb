require 'spec_helper'

RSpec.describe FileModel::Model::Base do
  let(:klass) do
    Class.new do
      include FileModel::Model::Base
    end
  end
  let(:instance) { klass.new('a/whatever/path', { index: 0, context: { a: :b }, previous: :nothing }) }

  it do
    expect(instance.context).to eql({ a: :b })
    expect(instance.source_path.to_s).to eql('a/whatever/path')
    expect(instance.index).to eql(0)
    expect(instance.previous).to eql(:nothing)
    expect(instance).to_not be_skip
  end

end
