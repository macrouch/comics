class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :volume

  validates :user_id, presence: true
  validates :volume_id, presence: true
end
