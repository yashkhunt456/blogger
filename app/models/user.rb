class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :lockable

  has_many :articles, dependent: :destroy 
  has_many :comments, dependent: :destroy

  validates :username, presence: true
  
  after_create :default_role

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "email", "id", "username"]
  end

  private

  def default_role
    self.add_role(:user) if self.roles.blank?
  end

end
