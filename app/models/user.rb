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

  require "csv"
  def self.to_csv
    attributes = %i[Id Username Email Roles Articles Created_at Updated_at]

    CSV.generate(headers: true) do |csv|
      csv << attributes
      all.each do |user|
        csv << [user.id, user.username, user.email, user.roles.map(&:name).join(", "), user.articles.map(&:title).join(", "), user.created_at, user.updated_at ]
      end
    end
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "email", "id", "username"]
  end

  private

  def default_role
    self.add_role(:user) if self.roles.blank?
  end

end
