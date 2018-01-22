require 'spec_helper'

RSpec.describe FileModel::Store::Memory do
  let(:model) { instance_double('FileModel::Model::File') }

  subject { FileModel::Store::Memory.instance }

  describe '#reset' do
    before { subject.reset! }

    it 'should not have any models registred' do
      expect(subject.models).to eql({})
    end
  end

  describe '#append_model' do
    context 'with nil name' do
      before { expect(model).to receive(:name).and_return(nil) }
      it 'should not be registred' do
        expect {
          subject.append_model(model)
        }.to_not change {
          subject.models
        }
      end
    end

    context 'with a model have a name' do
      before { expect(model).to receive(:name).at_least(:once).and_return('A Name') }
      it 'should be registred' do
        expect {
          subject.append_model(model)
        }.to change {
          subject.models.keys
        }.from([]).to(['A Name'])
      end

      after { subject.reset! }

      it 'alias is working' do
        expect {
          subject << model
        }.to change {
          subject.models.keys
        }.from([]).to(['A Name'])
      end
    end
  end
end
