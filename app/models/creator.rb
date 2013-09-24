class Creator < ActiveRecord::Base
  belongs_to :issue
  belongs_to :person
  belongs_to :role

  validates :issue, presence: true
  validates :person, presence: true
  validates :role, presence: true
end
