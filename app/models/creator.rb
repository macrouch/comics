class Creator < ActiveRecord::Base
  belongs_to :issue
  belongs_to :collected_edition
  belongs_to :person
  belongs_to :role

  validates :issue_id, uniqueness: { scope: :person }, allow_nil: true
  validates :collected_edition_id, uniqueness: { scope: :person }, allow_nil: true
  validates :person_id, presence: true
  validates :role_id, presence: true

  delegate :name, to: :person, prefix: true
  delegate :name, to: :role, prefix: true
end
