require 'spec_helper'

class MyModel
  include FileModel::Model::File
end

RSpec.describe FileModel::Import::Dir do
  let(:source_path) { 'spec/fixtures/archive/input' }
  let(:subject)     { described_class.new(source_path: source_path, model: MyModel, options: { a: :b }) }

  describe '#next' do
    it {
      instance = subject.next({ foo: :bar })
      expect(instance).to be_a(FileModel::Model::File)
      expect(instance.context).to eql({ a: :b, foo: :bar })
    }
  end

  describe '#each' do
    subject { described_class.new(source_path: source_path, model: klass) }

    context 'with skipping model' do
      let(:klass) do
        Class.new do
          include FileModel::Model::Base
          def skip?
            true
          end
        end

        it 'should not instantiate a model' do
          subject.each do |model|
            expect(model).to be_nil
          end
        end
      end
    end

    context 'with a none skipping model' do
      let(:klass) do
        Class.new do
          include FileModel::Model::Base
          def skip?
            false
          end
        end

        it 'should instantiate a model' do
          subject.each do |model|
            expect(model).to be_a(FileModel::Model::Base)
          end
        end
      end
    end
  end
end
