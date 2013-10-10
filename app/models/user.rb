class User < ActiveRecord::Base
  include Tokenable

  has_many :collections
  has_many :issues, through: :collections

  validates :name, presence: true
  validates :provider, presence: true
  validates :uid, presence: true
  validates :token, presence: true, uniqueness: true

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

  def add_issue(cv_id)
    issue = Issue.cv_find_or_create(cv_id)
    self.issues << issue
  end
end
