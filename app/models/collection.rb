class Collection < ActiveRecord::Base
  belongs_to :issue
  belongs_to :collected_edition
  belongs_to :user

  has_attached_file :variant

  # validates :issue_id, presence: true
  # validates :collected_edition_id, presence: true
  validate :issue_or_collected_edition
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

  private

  def issue_or_collected_edition
    if [issue, collected_edition].compact.size != 1
      errors.add(:base, "Collection must have either a issue or collected edition")
    end
  end
end
