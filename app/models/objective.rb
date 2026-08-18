class Objective < ApplicationRecord
  belongs_to :user
  has_many :sessions, dependent: :destroy
  has_many :chats

  validates :distance, presence: true
  validates :target_time, presence: true
  validates :prepa_duration, presence: true
  validates :frequency, presence: true
end
