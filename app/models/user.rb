class User < ActiveRecord::Base
  include Tokenable

  has_many :collections
  has_many :issues, through: :collections
  has_many :volumes, through: :issues
  has_many :subscriptions

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
    self.volumes.unscoped.joins(:issues).where('issues.id in (?)', self.collections.map{ |collection| collection.issue_id } ).group("volumes.id").order("count_issues_volume_id desc").limit(10).count("issues.volume_id")
  end

  def issues_by_volume(volume)
    self.issues.where(volume: volume).uniq
  end

  def add_issue(cv_id)
    issue = Issue.cv_find_or_create(cv_id)
    self.issues << issue
    return issue
  end

  def add_variant(cv_id, image_url, name)
    issue = Issue.cv_find_or_create(cv_id)
    user = self
    collection = Collection.new(user: user, issue: issue)
    collection.variant_name = name
    collection.variant_from_url(image_url)
    collection.save
    return collection
  end

  def is_subscribed?(volume_id)
    volume = Volume.cv_find_or_create(volume_id)
    volume.nil? ? false : self.subscriptions.where(volume: volume).first
  end

  def add_subscription(volume_id)
    volume = Volume.cv_find_or_create(volume_id)
    self.subscriptions.create!({volume: volume})
  end

  def remove_subscription(volume_id)
    volume = Volume.where(cv_id: volume_id).first
    subscription = self.subscriptions.where(volume: volume).first
    subscription.destroy
  end

  def pull_box
    volumes = self.subscriptions.map {|s| s.volume }
    issues_by_volume = volumes.map{ |v| v.issues }
    issues_by_volume.map { |issues| issues.where('id not in (?) AND CAST(issue_number AS DECIMAL(6,2)) > (?)', self.collections.map{ |collection| collection.issue_id }, self.last_owned_issue(issues.first.volume_id) ) }.flatten
  end

  def last_owned_issue(volume_id)
    self.issues.where(volume_id: volume_id).maximum("CAST(issue_number AS DECIMAL(6,2))").to_f
  end

  def new_token
    generate_token
    self.save
  end
end
