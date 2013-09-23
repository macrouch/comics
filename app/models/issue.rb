class Issue < ActiveRecord::Base
  belongs_to :volume
  belongs_to :user

  has_many :creators
  has_and_belongs_to_many :characters

  has_attached_file :cover

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
