require 'spec_helper'

RSpec.describe FileModel::Model::File do
  let(:instance) { described_class.new('a/whatever/path/image.png', { root_path: 'a/whatever/', context: { a: :b }}) }
  it do
    expect(instance.exploded_path).to eql(["a", "whatever", "path", "image.png"])
    expect(instance.name).to eql('image')
    expect(instance.full_name).to eql('image.png')
    expect(instance.extension).to eql('png')
    expect(instance.dir_path).to eql('path')
    expect(instance.file_path).to eql('path/image.png')
  end
end
