class Attachment < ApplicationRecord

  belongs_to :user
  has_one_attached :upload
  has_many :link_codes, as: :linkable, dependent: :destroy

  validates :upload, presence: true,
                     content_type: ['image/png', 'image/jpg', 'image/jpeg',
                      "audio/mpeg", "application/pdf", 'audio/midi', 'video/webm', 'video/mp4',
                      "text/csv", "application/vnd.ms-excel"],
                     size: { less_than: 1.gigabytes , message: 'is not given between size' }

  after_create :create_share_link_code
  before_create :set_title

  private
    def create_share_link_code
      link_codes.create!(expire_at: 1.year.from_now, link_type: 'upload_share_link')
    end

    def set_title
      self.title = "Attachment-#{Time.current.strftime("%d%m%Y%H%M")}" unless title.present?
    end
end