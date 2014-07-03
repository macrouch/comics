require 'spec_helper'

describe Subscription do
  it { should belong_to :user }
  it { should belong_to :volume }
  it { should validate_presence_of :user_id }
  it { should validate_presence_of :volume_id }
end
