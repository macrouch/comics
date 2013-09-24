class Person < ActiveRecord::Base
  has_many :creators

  validates :cv_id, presence: true, uniqueness: true
  validates :name, presence: true

  def self.from_cv_id_and_name(cv_id, name)
    person = Person.where(cv_id: cv_id).first
    unless person
      person = Person.new
      person.cv_id = cv_id
      person.name = name
      person.save
    end
    person    
  end
end
