require 'spec_helper'

RSpec.describe FileModel::Export::Dir do
  let(:model) do
    FileModel::Model::File.new('a/whatever/path/image.png', { root_path: 'a/whatever' })
  end

  let(:export_path) { 'tmp' }
  let(:subject)     { described_class.new(export_path: export_path, processor: processor, options: { a: :b }) }
  let(:processor)   { FileModel::Processor::Prefix }

  before do
    store = FileModel::Store::Memory.instance
    store.reset!
    store.append_model(model)
  end

  before do
    expect_any_instance_of(processor).to receive(:copy).with(
      OpenStruct.new(path: 'a/whatever/path/image.png'),
      OpenStruct.new(path: 'tmp/path/prefix/image.png')
    )
  end

  describe '#each' do
    it do
      subject.each do |model|
        expect(model.source_path).to eql('a/whatever/path/image.png')
      end
    end
  end

  describe '#next' do
    it 'implement Enumerator Pattern' do
      enum  = subject.each.to_enum
      model = enum.next
      expect(model.source_path).to eql('a/whatever/path/image.png')
    end
  end
end
