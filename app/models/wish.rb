class Wish < ActiveRecord::Base
  VALID_URL_REGEX = /^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-=\?]*)*\/?$/
  belongs_to :user

  validates :name, presence: true, length: {in: 5..100}
  validates :price, presence: true
  validates :link, format: {with: VALID_URL_REGEX, multiline: true}
  validates :user_id, presence: true
end
