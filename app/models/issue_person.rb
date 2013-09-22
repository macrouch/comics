class IssuePerson < ActiveRecord::Base
  belongs_to :issue
  belongs_to :person
  belongs_to :role
end
