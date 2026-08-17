class Session < ApplicationRecord
  belongs_to :objective

  validates :type, presence: true
  validates :distance, presence: true
  validates :pace, presence: true
  validates :content, presence: true
end
