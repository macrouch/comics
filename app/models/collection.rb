class Collection < ActiveRecord::Base
  belongs_to :issue
  belongs_to :user

  has_attached_file :variant

  validates :issue_id, presence: true
  validates :user_id, presence: true

  delegate :volume, to: :issue

  def variant_from_url(url)
    self.variant = URI.parse(url)
  end

  def is_variant?
    !variant_file_name.nil?
  end

  def to_s
    "#{issue.to_s} (#{self.variant_name})"
  end
end
