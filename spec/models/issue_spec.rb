require 'spec_helper'

describe Issue do
  it { should belong_to :volume }
  it { should have_many :collections }
  it { should have_many(:users).through(:collections) }
  it { should have_many :creators }
  it { should have_and_belong_to_many :characters }
  it { should validate_presence_of :cv_id }
  it { should validate_uniqueness_of :cv_id }
  # it { should validate_presence_of :name }
  it { should validate_presence_of :site_detail_url }
  # it { should validate_presence_of :store_date }
  it { should validate_presence_of :volume }
  it { should have_attached_file :cover }
  it { should validate_attachment_presence :cover }

  it "creates issue from api" do
    issue = Issue.cv_find_or_create(293259)
    issue.should be_valid
  end
end
