class Volume < ActiveRecord::Base
  belongs_to :publisher
  has_many :users, through: :issues
  has_many :issues
  has_many :collected_editions
  has_many :subscriptions

  validates :cv_id, presence: true, uniqueness: true
  validates :name, presence: true
  validates :publisher_id, presence: true
  validates :start_year, presence: true

  default_scope { order(:name) }

  ID_PREFIX = '4050-'

  def self.cv_find_or_create(cv_id)
    cv_id = cv_id.start_with?(ID_PREFIX) ? cv_id : ID_PREFIX + cv_id
    volume = Volume.where(cv_id: cv_id).first
    unless volume
      result = ComicVine.find_volume(cv_id)['results']
      volume = Volume.new
      volume.cv_id = cv_id
      volume.name = result['name']
      volume.start_year = result['start_year']
      # volume.publisher = Publisher.cv_find_or_create(result['publisher']['id'])
      volume.publisher = Publisher.from_cv_id_and_name(result['publisher']['id'].to_s,result['publisher']['name'])
      volume.save
    end
    volume
  end

  def to_s
    "#{self.name} (#{start_year})"
  end

  def number_issues
    self.issues.size
  end
end
