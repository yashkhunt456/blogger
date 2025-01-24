class Article < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  has_many_attached :images do |attachable|
    attachable.variant :thumb, resize_to_limit: [nil, 200]
  end

  has_one_attached :document
  has_one_attached :video do |attachable|
    attachable.variant :thumb, resize_to_limit: [500, nil]
  end

  validates :title, :content, presence: true
  validates :content, length: { in: 10..1000 }


  def self.ransackable_attributes(auth_object = nil)
    ["content", "created_at", "id", "title", "updated_at", "user_id"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["comments", "user"]
  end

end
