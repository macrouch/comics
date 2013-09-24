class Role < ActiveRecord::Base
  has_many :creators

  validates :name, presence: true, uniqueness: true
end
