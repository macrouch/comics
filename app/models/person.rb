class Person < ActiveRecord::Base
  has_many :creators

  validates :cv_id, presence: true, uniqueness: true
  validates :name, presence: true

  ID_PREFIX = '4040-'

  def self.from_cv_id_and_name(cv_id, name)
    cv_id = cv_id.start_with?(ID_PREFIX) ? cv_id : ID_PREFIX + cv_id
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
