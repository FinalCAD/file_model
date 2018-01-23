RSpec.describe FileModel do
  it "has a version number" do
    expect(FileModel::VERSION).not_to be nil
  end

  before do
    FileModel.configure do |config|
      config.store = :redis
    end
  end

  it do
    expect(FileModel.configuration.store).to eql(:redis)
  end

  after do
    FileModel.reset
  end
end
