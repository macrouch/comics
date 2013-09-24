class Volume < ActiveRecord::Base
  belongs_to :publisher

  validates :cv_id, presence: true, uniqueness: true
  validates :name, presence: true
  validates :publisher, presence: true
  validates :start_year, presence: true

  def self.cv_find_or_create(cv_id)
    volume = Volume.where(cv_id: cv_id).first
    unless volume
      result = ComicVine.find_volume(cv_id)['results']
      volume = Volume.new
      volume.cv_id = cv_id
      volume.name = result['name']
      volume.start_year = result['start_year']
      # volume.publisher = Publisher.cv_find_or_create(result['publisher']['id'])
      volume.publisher = Publisher.from_cv_id_and_name(result['publisher']['id'],result['publisher']['name'])
      volume.save
    end
    volume
  end
end
