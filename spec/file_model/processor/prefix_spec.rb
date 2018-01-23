require 'spec_helper'

RSpec.describe FileModel::Processor::Prefix do
  let(:model) do
    FileModel::Model::File.new('a/whatever/path/image.png', { root_path: 'a/whatever' })
  end

  let(:instance) { described_class.new }

  before do
    expect(instance).to receive(:copy).with(
      OpenStruct.new(path: 'a/whatever/path/image.png'),
      OpenStruct.new(path: 'somewhere/else/path/prefix/image.png')
    )
  end

  it do
    instance.process(model: model, context: { export_path: 'somewhere/else' })
  end
end
