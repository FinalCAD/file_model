require 'spec_helper'

RSpec.describe FileModel::Model::File do
  let(:instance) do
    Class.new do
      include FileModel::Model::File
    end.new('a/whatever where/path/image.png', { root_path: 'a/whatever where/', context: { a: :b }})
  end

  it do
    expect(instance.exploded_path).to eql(["a", "whatever where", "path", "image.png"])
    expect(instance.name.to_s).to eql('image')
    expect(instance.full_name.to_s).to eql('image.png')
    expect(instance.extension.to_s).to eql('.png')
    expect(instance.dir_path.to_s).to eql('path')
    expect(instance.file_path.to_s).to eql('path/image.png')
    expect(instance.escaped.to_s).to eql('a/whatever\ where/path/image.png')
  end
end
