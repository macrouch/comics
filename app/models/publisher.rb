class Publisher < ActiveRecord::Base
  has_many :volumes

  def self.cv_find_or_create(cv_id)
    publisher = Publisher.where(cv_id: cv_id).first
    unless publisher
      result = ComicVine.find_publisher(cv_id)['results']
      publisher = Publisher.new
      publisher.cv_id = cv_id
      publisher.name = result['name']
      publisher.save
    end
    publisher
  end

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
