class LinkCode < ApplicationRecord

  enum status: { active: 1, expired: 2 }

  belongs_to :linkable, polymorphic: true


  validates :code, :linkable_id, :linkable_type, :expire_at, presence: true
  validates_uniqueness_of :code

  before_validation :set_status, on: :create
  before_validation :set_code, on: :create
  before_validation :set_expire_at, on: :create

  def expire_now!
    update!({ status: :expired, expire_at: Time.current })
  end

  private
    def set_code
      self.code = SecureRandom.hex(6)
    end

    def set_status
      self.status = :active unless status.present?
    end

    def set_expire_at
      self.expire_at = (expire_at.presence || (Time.current + 7.days))
    end
end