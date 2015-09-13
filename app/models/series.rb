class Series < ActiveRecord::Base
  belongs_to :user
  has_many :seasons

#  serialize :key_words
end
