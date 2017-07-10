class Talk < ApplicationRecord
  include ::Searchable
  include Publishable

  extend FriendlyId
  friendly_id :title, use: :slugged

  acts_as_taggable

  belongs_to :event
  belongs_to :speaker, class_name: 'User'
  belongs_to :group

  scope :sorted,         -> { order(:title) }
  scope :sorted_by_date, -> { order(created_at: :desc) }

  validates :title, presence: true

  mount_uploader :cover, TalkCoverUploader

  # Issue: https://github.com/mbleigh/acts-as-taggable-on/issues/91#issuecomment-168273770
  def tag_list
    @tag_list ||= ActsAsTaggableOn::TagList.new tags.collect(&:name)
  end

  def extra_video_data
    {
      video_duration:    extra['video_duration'],
      video_likes_count: extra['video_likes_count'],
      video_views_count: extra['video_views_count'],
    }
  end
end
