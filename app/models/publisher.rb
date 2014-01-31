class Publisher < ActiveRecord::Base
  has_many :volumes
  
  validates :cv_id, presence: true, uniqueness: true
  validates :name, presence: true

  default_scope { order(:name) }

  ID_PREFIX = '4010-'

  def self.from_cv_id_and_name(cv_id, name)
    cv_id = cv_id.start_with?(ID_PREFIX) ? cv_id : ID_PREFIX + cv_id
    publisher = Publisher.where(cv_id: cv_id).first
    unless publisher
      publisher = Publisher.new
      publisher.cv_id = cv_id
      publisher.name = name
      publisher.save
    end
    publisher
  end
end
