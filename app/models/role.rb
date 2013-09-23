class Role < ActiveRecord::Base
  has_many :creators
end
