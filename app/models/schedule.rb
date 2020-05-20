class Schedule < ApplicationRecord
  belongs_to :user

  has_many :time_slots, dependent: :destroy

  validates :title, :description, presence: true
end
