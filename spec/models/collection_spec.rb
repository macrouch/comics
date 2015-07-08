require 'spec_helper'

describe Collection do
  it { should belong_to :issue }
  it { should belong_to :collected_edition }
  it { should belong_to :user }
  # it { should validate_presence_of :issue_id }
  it { should validate_presence_of :user_id }
end
