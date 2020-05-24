# frozen_string_literal: true

class HeadHunter < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :validatable, :lockable, :timeoutable, :trackable

  has_one_attached :avatar
  has_many :jobs, dependent: :nullify
  has_many :applications, through: :jobs
  has_many :applicants, through: :jobs
  has_many :offers, dependent: :destroy, class_name: Job::Application::Offer.name,
                        foreign_key: 'head_hunter_id'

  before_save { email.downcase! }
  before_save { self.name = name.titleize }
  before_save { self.social_name = social_name.titleize if social_name }

  validates :email, presence: true, uniqueness: true, length: { maximum: 255 }
  validates :name, presence: true, length: { minimum: 5 }
  validates :avatar, presence: true

  def resolve_name
    return social_name if social_name

    name
  end
end
