require 'spec_helper'

describe Character do
  it { should have_and_belong_to_many :issues }
  it { should have_and_belong_to_many :collected_editions }
  it { should validate_presence_of :cv_id }
  it { should validate_uniqueness_of :cv_id }
  it { should validate_presence_of :name }

  it "creates character from attributes" do
    character = Character.from_cv_id_and_name('4005-1699', 'Batman')
    character.should be_valid
  end
end
