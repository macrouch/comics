class Issue < ActiveRecord::Base
  belongs_to :volume

  has_many :collections
  has_many :users, through: :collections
  has_many :creators
  has_and_belongs_to_many :characters, -> { uniq }

  has_attached_file :cover

  validates :cv_id, presence: true, uniqueness: true
  validates :issue_number, presence: true
  validates :site_detail_url, presence: true
  validates :volume_id, presence: true
  validates :cover, attachment_presence: true

  delegate :name, to: :volume, prefix: true
  delegate :publisher, to: :volume

  default_scope { order("CAST(issue_number AS DECIMAL(6,2)) ASC") }

  ID_PREFIX = '4000-'

  def to_s
    "#{self.volume_name}, ##{self.issue_number} - #{self.name}"
  end

  def cover_from_url(url)
    self.cover = URI.parse(url)
  end

  def self.cv_find_or_create(cv_id)
    cv_id = cv_id.start_with?(ID_PREFIX) ? cv_id : ID_PREFIX + cv_id
    issue = Issue.where(cv_id: cv_id).first
    unless issue
      result = ComicVine.find_issue(cv_id)['results']
      issue = Issue.new
      issue.cv_id = cv_id
      issue.set_properties(result)
    end
    issue
  end

  def cv_update
    result = ComicVine.find_issue(cv_id)['results']
    self.set_properties(result)
  end

  def set_properties(result)
    self.name = result['name']
    self.issue_number = result['issue_number']
    self.site_detail_url = result['site_detail_url']
    self.store_date = result['store_date']
    self.volume = Volume.cv_find_or_create(result['volume']['id'].to_s)
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
        creator.issue = self
        creator.role = role
        creator.save
      end
    end
    self.save
  end
end
