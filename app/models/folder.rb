class Folder < ActiveRecord::Base
  has_many :documents
  belongs_to :user

  validates :name, presence: true, length: { in: 5..50 }
  validates :user_id, presence: true

  before_destroy :delete_documents

  private

  def delete_documents
    documents.destroy_all
  end
end
