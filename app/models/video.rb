class Video < ApplicationRecord
  SOURCES = %w[youtube vimeo].freeze

  validates :source, :source_id, :title, presence: true
  validates :source, inclusion: { in: SOURCES }

  belongs_to :user

  def youtube?
    source == 'youtube'
  end

  def vimeo?
    source == 'vimeo'
  end
end
