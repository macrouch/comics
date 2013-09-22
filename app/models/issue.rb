class Issue < ActiveRecord::Base
  belongs_to :volume
  belongs_to :user

  has_many :people, through: :issue_people
  has_and_belongs_to_many :characters

  has_attached_file :cover

  def cover_from_url(url)
    self.cover = URI.parse(url)    
  end
end
