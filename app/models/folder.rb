class Folder < ActiveRecord::Base
  has_many :documents
  belongs_to :user

  validates :name, presence: true, length: {in: 5..50}
  validates :user_id, presence: true
end
