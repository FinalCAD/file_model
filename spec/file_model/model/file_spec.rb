require 'spec_helper'

RSpec.describe FileModel::Model::File do
  let(:instance) { described_class.new('a/whatever/path/image.png', { context: { a: :b }}) }
  it do
    expect(instance.exploded_path).to eql(["a", "whatever", "path", "image.png"])
    expect(instance.name).to eql('image')
    expect(instance.extension).to eql('png')
  end
end
