class User < ApplicationRecord
  attachment :profile_image
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  # フォロー機能
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverse_of_relationships, source: :user

  # バリデート
  validates :name, presence: true, uniqueness: true, length: {in:2..20}
  validates :introduction,length: { maximum: 50}

  # フォロー機能メソッド
  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end
    # ユーザー検索機能メソッド
  # def self.search(search)
  #   if search
  #      if params[:select_a] == "User" && params[:select_b] == "部分一致"
  #       User.where(['name LIKE ?', "%#{search}%"])
  #      end
  #
  #   else
  #     User.all
  #   end
  # end
end
