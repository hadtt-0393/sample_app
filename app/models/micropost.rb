class Micropost < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  validates :content, presence: true,
            length: {maximum: Settings.digits.length_140}
  validates :image, content_type: {in: Settings.model.image_type,
                                   message: I18n.t(".content_type_message")},
                    size: {less_than: 5.megabytes,
                           message: I18n.t(".size_message")}

  scope :latest, ->{order created_at: :desc}

  delegate :name, to: :user, prefix: true, allow_nil: true

  def display_image
    image.variant(resize_to_limit: [500, 500])
  end
end
