class Article < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :title, :content, presence: true
  validates :content, length: { in: 10..1000 }

  def self.ransackable_attributes(auth_object = nil)
    ["content", "created_at", "id", "title", "updated_at", "user_id"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["comments", "user"]
  end

end
