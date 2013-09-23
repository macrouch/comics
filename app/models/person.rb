class Person < ActiveRecord::Base
  has_many :issues, through: :issue_people

  def self.cv_find_or_create(cv_id)
    person = Person.where(cv_id: cv_id).first
    unless person
      result = ComicVine.find_person(cv_id)['results']
      person = Person.new
      person.cv_id = cv_id
      person.name = result['name']
      person.save
    end
    person
  end

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
