class Creator < ActiveRecord::Base
  belongs_to :issue
  belongs_to :person
  belongs_to :role

  validates :issue, presence: true, uniqueness: { scope: :person }
  validates :person, presence: true
  validates :role, presence: true

  delegate :name, to: :person, prefix: true
  delegate :name, to: :role, prefix: true
end
