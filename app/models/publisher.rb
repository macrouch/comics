class Publisher < ActiveRecord::Base
  has_many :volumes
  
  validates :cv_id, presence: true, uniqueness: true
  validates :name, presence: true

  def self.from_cv_id_and_name(cv_id, name)
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
