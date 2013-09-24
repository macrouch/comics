class Collection < ActiveRecord::Base
  belongs_to :issue
  belongs_to :user

  validates :issue, presence: true
  validates :user, presence: true
end
