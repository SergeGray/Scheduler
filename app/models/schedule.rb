class Schedule < ApplicationRecord
  validates :title, :description, presence: true
end
