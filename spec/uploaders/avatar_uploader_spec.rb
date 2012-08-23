require 'carrierwave/test/matchers'

describe AvatarUploader do
  include CarrierWave::Test::Matchers

  before :each do
    @user = FactoryGirl.create :user

    AvatarUploader.enable_processing = true
    @uploader = AvatarUploader.new @user, :avatar
    @uploader.store!(File.open("#{Rails.root}/features/fixtures/test.png"))
  end

  after :each do
    AvatarUploader.enable_processing = false
    @uploader.remove!
  end

  it 'should scale the avatar to exactly 220 by 300 pixels' do
    @uploader.should have_dimensions(220, 300)
  end

  context 'small version' do
    it 'should scale down the avatar be exactly 48 by 48 pixels' do
      @uploader.small.should have_dimensions(48, 48)
    end
  end

  context 'tiny version' do
    it 'should scale down avatar be exactly 20 by 20 pixels' do
      @uploader.tiny.should have_dimensions(20, 20)
    end
  end
end
