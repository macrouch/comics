require 'spec_helper'

describe Person do
  it { should have_many :creators }
  it { should validate_presence_of :cv_id }
  it { should validate_uniqueness_of :cv_id }
  it { should validate_presence_of :name }

  it "creates person from attributes" do
    person = Person.from_cv_id_and_name('4040-12345', 'Joe Smith')
    person.should be_valid
  end
end
