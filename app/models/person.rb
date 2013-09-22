class Person < ActiveRecord::Base
  has_many :issues, through: :issue_people
end
