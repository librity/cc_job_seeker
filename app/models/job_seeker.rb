# frozen_string_literal: true

class JobSeeker < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :validatable, :lockable, :timeoutable, :trackable

  before_save { email.downcase! }
  before_save { self.name = name.titleize }

  validates :email, presence: true, uniqueness: true, length: { maximum: 255 }
  validates :name, presence: true, length: { minimum: 5 }
end
