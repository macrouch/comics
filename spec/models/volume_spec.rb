require 'spec_helper'

describe Volume do
  it { should belong_to :publisher }
  it { should validate_presence_of :cv_id }
  it { should validate_uniqueness_of :cv_id }
  it { should validate_presence_of :name }
  it { should validate_presence_of :publisher_id }
  it { should validate_presence_of :start_year }

  it "creates volume from api" do
    VCR.use_cassette 'api_calls' do
      volume = Volume.cv_find_or_create(42721)
      volume.should be_valid
    end
  end
end
