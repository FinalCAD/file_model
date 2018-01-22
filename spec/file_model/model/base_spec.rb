require 'spec_helper'

RSpec.describe FileModel::Model::Base do
  let(:klass) do
    Class.new do
      include FileModel::Model::Base
    end
  end
  let(:instance) { klass.new('a/whatever/path', { context: { a: :b }}) }

  it do
    expect(instance.context).to eql({ a: :b })
    expect(instance.source_path).to eql('a/whatever/path')
    expect(instance.index).to eql(nil)
  end
end
