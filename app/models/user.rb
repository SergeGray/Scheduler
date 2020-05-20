class User < ApplicationRecord
  has_many :schedules, dependent: :destroy
  has_many :appointments, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
