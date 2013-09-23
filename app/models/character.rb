class Character < ActiveRecord::Base
  has_and_belongs_to_many :issues

  def self.cv_find_or_create(cv_id)
    character = Character.where(cv_id: cv_id).first
    unless character
      result = ComicVine.find_character(cv_id)['results']
      character = Character.new
      character.cv_id = cv_id
      character.name = result['name']
      character.save
    end
    character
  end

  def self.from_cv_id_and_name(cv_id, name)
    character = Character.where(cv_id: cv_id).first
    unless character
      character = Character.new
      character.cv_id = cv_id
      character.name = name
      character.save
    end
    character    
  end
end
