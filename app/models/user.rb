class User < ActiveRecord::Base
  include Tokenable

  has_many :collections
  has_many :issues, through: :collections

  validates :name, presence: true
  validates :provider, presence: true
  validates :uid, presence: true
  validates :token, uniqueness: true

  def self.from_omniauth(auth)
    where(auth.slice('provider', 'uid')).first || create_from_omniauth(auth)    
  end

  def self.create_from_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      user.name = auth['info']['name']
    end
  end

  def publishers
    self.issues.map{ |issue| issue.publisher }.uniq
  end

  def top_volumes
    self.issues.group(:volume_id).order('count_id desc').limit(10).count('id')
  end

  def issues_by_volume(volume)
    self.issues.where(volume: volume).uniq
  end

  def add_issue(cv_id)
    issue = Issue.cv_find_or_create(cv_id)
    self.issues << issue
  end

  def add_variant(cv_id, image_url, name)
    issue = Issue.cv_find_or_create(cv_id)
    user = self
    collection = Collection.new(user: user, issue: issue)
    collection.variant_name = name
    collection.variant_from_url(image_url)
    collection.save
  end

  def new_token
    generate_token
    self.save    
  end
end
