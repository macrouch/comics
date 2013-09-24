require 'spec_helper'

describe Publisher do
  it { should have_many :volumes }
  it { should validate_presence_of :cv_id }
  it { should validate_uniqueness_of :cv_id }
  it { should validate_presence_of :name }

  it "creates publisher from attributes" do
    publisher = Publisher.from_cv_id_and_name(12345, 'DC Comics')
    publisher.should be_valid
  end
end
