require 'spec_helper'

describe User do
  
  it { should have_many :collections }
  it { should have_many(:issues).through(:collections) }
  it { should validate_presence_of :name }
  it { should validate_presence_of :provider }
  it { should validate_presence_of :uid }
end
