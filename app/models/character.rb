class Character < ActiveRecord::Base
  has_and_belongs_to_many :issues

  validates :cv_id, presence: true, uniqueness: true
  validates :name, presence: true

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
