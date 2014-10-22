class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :volume

  validates :user_id, presence: true
  validates :volume_id, presence: true

  def self.pull_subscriptions
    # TODO only pull uniq volumes
    Subscription.all.each do |subscription|
      volume = subscription.volume
      get_issues(volume)
    end
  end

  def check
    volume = self.volume
    get_issues(volume)
  end

  private

  def get_issues(volume)
    issues = ComicVine.find_issues_by_volume(volume.cv_id.split('-')[1])['results']
    issues.each do |issue|
      Issue.cv_find_or_create(issue['id'].to_s)
    end
  end
end
