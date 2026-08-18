class Seance < ApplicationRecord
  belongs_to :objective

  validates :session_type, presence: true
  validates :distance, presence: true
  validates :pace, presence: true
  validates :content, presence: true
end
