class Creator < ActiveRecord::Base
  belongs_to :issue
  belongs_to :person
  belongs_to :role

end
