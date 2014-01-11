class Creator < ActiveRecord::Base
  belongs_to :issue
  belongs_to :person
  belongs_to :role

  validates :issue_id, uniqueness: { scope: :person }
  validates :person_id, presence: true
  validates :role_id, presence: true

  delegate :name, to: :person, prefix: true
  delegate :name, to: :role, prefix: true
end
