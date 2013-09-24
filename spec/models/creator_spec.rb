require 'spec_helper'

describe Creator do
  it { should belong_to :issue }
  it { should belong_to :person }
  it { should belong_to :role }
  it { should validate_presence_of :issue }
  it { should validate_presence_of :person }
  it { should validate_presence_of :role }
end
