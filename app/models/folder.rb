class Folder < ActiveRecord::Base
  has_many :documents
  belongs_to :user
end
