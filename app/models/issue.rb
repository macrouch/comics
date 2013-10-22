class Issue < ActiveRecord::Base
  belongs_to :volume

  has_many :collections
  has_many :users, through: :collections
  has_many :creators
  has_and_belongs_to_many :characters

  has_attached_file :cover

  validates :cv_id, presence: true, uniqueness: true
  validates :issue_number, presence: true
  # validates :name, presence: true
  validates :site_detail_url, presence: true
  # validates :store_date, presence: true
  validates :volume, presence: true
  validates :cover, attachment_presence: true

  delegate :name, to: :volume, prefix: true
  delegate :publisher, to: :volume

  default_scope order("CAST(issue_number AS DECIMAL)")

  def to_s
    "#{self.volume_name}, ##{self.issue_number} - #{self.name}"
  end

  def cover_from_url(url)
    self.cover = URI.parse(url)    
  end

  def self.cv_find_or_create(cv_id)
    issue = Issue.where(cv_id: cv_id).first
    unless issue
      result = ComicVine.find_issue(cv_id)['results']
      issue = Issue.new
      issue.cv_id = cv_id
      issue.name = result['name']
      issue.issue_number = result['issue_number']
      issue.site_detail_url = result['site_detail_url']
      issue.store_date = result['store_date']
      issue.volume = Volume.cv_find_or_create(result['volume']['id'])
      issue.cover_from_url(result['image']['super_url'])
      result['character_credits'].each do |character|
        issue.characters << Character.from_cv_id_and_name(character['id'], character['name'])
      end
      result['person_credits'].each do |p|
        role = Role.where(name: p['role']).first
        if role
          person = Person.from_cv_id_and_name(p['id'], p['name'])
          creator = Creator.new
          creator.person = person
          creator.issue = issue
          creator.role = role
          creator.save
        end
      end
      issue.save
    end
    issue
  end
end
