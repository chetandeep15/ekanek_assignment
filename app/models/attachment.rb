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
  after_create :cropped_image

  def cropped_image
    path = ActiveStorage::Blob.service.send(:path_for, upload.blob.key)
    customize_image = MiniMagick::Image.open(path)
    customize_image.crop("100x100+0+0")
    file = File.open(customize_image.path)
    filename = Time.zone.now.strftime("%Y%m%d%H%M%S") + upload.blob.filename.to_s
    upload.attach(io: file, filename: filename)
  end
  private
    def create_share_link_code
      link_codes.create!(expire_at: 1.year.from_now, link_type: 'upload_share_link')
    end

    def set_title
      self.title = "Attachment-#{Time.current.strftime("%d%m%Y%H%M")}" unless title.present?
    end
end