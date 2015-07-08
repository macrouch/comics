class Character < ActiveRecord::Base
  has_and_belongs_to_many :issues
  has_and_belongs_to_many :collected_editions

  validates :cv_id, presence: true, uniqueness: true
  validates :name, presence: true

  ID_PREFIX = '4005-'

  def self.from_cv_id_and_name(cv_id, name)
    cv_id = cv_id.start_with?(ID_PREFIX) ? cv_id : ID_PREFIX + cv_id
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
