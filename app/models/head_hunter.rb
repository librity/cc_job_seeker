# frozen_string_literal: true

class HeadHunter < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :validatable, :lockable, :timeoutable, :trackable

  has_many :jobs, dependent: :nullify

  before_save { email.downcase! }
  before_save { self.name = name.titleize }
  before_save { self.social_name = social_name.titleize if social_name }

  validates :email, presence: true, uniqueness: true, length: { maximum: 255 }
  validates :name, presence: true, length: { minimum: 5 }

  def resolve_name
    return social_name if social_name

    name
  end
end
