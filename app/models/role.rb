class Role < ActiveRecord::Base
  has_many :issue_people
end
