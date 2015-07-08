class CollectedEdition < ActiveRecord::Base
  belongs_to :volume

  has_many :collections
  has_many :users, through: :collections
  has_many :creators
  has_and_belongs_to_many :characters, -> { uniq }

  has_attached_file :cover

  validates :cv_id, presence: true, uniqueness: true
  validates :volume_number, presence: true
  validates :site_detail_url, presence: true
  validates :volume_id, presence: true
  validates :cover, attachment_presence: true

  delegate :name, to: :volume, prefix: true
  delegate :publisher, to: :volume

  attr_accessor :volume_id_select

  ID_PREFIX = '4000-'

  def to_s
    "#{self.volume_name}, ##{self.volume_number} - #{self.name}"
  end

  def cover_from_url(url)
    self.cover = URI.parse(url)
  end

  def self.cv_find_or_create(cv_id, volume_id=nil)
    cv_id = cv_id.start_with?(ID_PREFIX) ? cv_id : ID_PREFIX + cv_id
    collected_edition = CollectedEdition.where(cv_id: cv_id).first
    unless collected_edition
      result = ComicVine.find_issue(cv_id)['results']
      collected_edition = CollectedEdition.new
      collected_edition.cv_id = cv_id
      collected_edition.set_properties(result, volume_id)
    end
    collected_edition
  end

  def cv_update
    result = ComicVine.find_issue(cv_id)['results']
    self.set_properties(result)
  end

  def set_properties(result, volume_id=nil)
    self.name = result['volume']['name']
    self.volume_number = result['name']
    self.site_detail_url = result['site_detail_url']

    # TODO volume from user entry
    # self.volume = Volume.cv_find_or_create(result['volume']['id'].to_s)
    self.volume = Volume.cv_find_or_create(volume_id) if volume_id

    self.cover_from_url(result['image']['small_url'])
    result['character_credits'].each do |character|
      self.characters << Character.from_cv_id_and_name(character['id'].to_s, character['name'])
    end
    result['person_credits'].each do |p|
      role = Role.where(name: p['role']).first
      if role
        person = Person.from_cv_id_and_name(p['id'].to_s, p['name'])
        creator = Creator.new
        creator.person = person
        creator.collected_edition = self
        creator.role = role
        creator.save
      end
    end
    self.save
  end
end
