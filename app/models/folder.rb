class Folder < ActiveRecord::Base
  has_many :documents
  belongs_to :user

  validates :name, presence: true, length: {in: 5..50}
  validates :user_id, presence: true

  def from_user(user)
    Folder.where(:user_id => user.id)
  end
end
