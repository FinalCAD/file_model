require 'spec_helper'

RSpec.describe FileModel::Model::File do
  let(:instance) { described_class.new('a/whatever/path', { context: { a: :b }}) }
  it do
    expect(instance.exploded_path).to eql(["a", "whatever", "path"])
  end
end
