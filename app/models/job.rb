# frozen_string_literal: true

class Job < ApplicationRecord
  BRAZILIAN_MINIMUM_WAGE = 1039

  belongs_to :head_hunter
  has_many :applications, dependent: :destroy, class_name: Job::Application.name
  has_many :applicants, through: :applications, source: :job_seeker

  validates :title, presence: true
  validates :description, presence: true, length: { minimum: 50 }
  validates :skills, presence: true
  validates :salary_floor,
            numericality: { only_integer: true,
                            greater_than_or_equal_to: BRAZILIAN_MINIMUM_WAGE,
                            less_than: 50_000 }, presence: true
  validates :salary_roof, numericality: { only_integer: true, less_than: 50_200 },
                          presence: true
  validate :salary_roof_is_greater_than_salary_floor_by_at_least_200
  validates :position, presence: true
  validates :location, presence: true
  validates :retired, inclusion: { in: [true, false] }
  VALID_DATE_REGEX = /\d{4}-\d{2}-\d{2}/.freeze
  validates :expires_on, presence: true, format: { with: VALID_DATE_REGEX }
  validate :whether_expires_on_at_least_one_month_from_now
  validates :head_hunter, presence: true

  before_save :titleize_attributes

  default_scope -> { order expires_on: :desc }
  scope :created_by, ->(head_hunter) { where head_hunter: head_hunter }
  scope :active, -> { where "retired = FALSE AND expires_on > DATE('now')" }
  scope :by_title_or_description, lambda { |search|
                                    where 'title like ? OR description like ?',
                                          "%#{search}%", "%#{search}%"
                                  }

  def expired?
    expires_on < Date.today
  end

  def active?
    return false if expired?

    !retired
  end

  def minimum_wage
    BRAZILIAN_MINIMUM_WAGE
  end

  def ongoing_applications
    applications.where rejection_feedback: nil
  end

  private

  def salary_roof_is_greater_than_salary_floor_by_at_least_200
    return if salary_floor.nil?
    return if salary_roof && salary_roof >= salary_floor + 200

    errors.add :salary_roof, :greater_than_or_equal_to, count: salary_floor + 200
  end

  def whether_expires_on_at_least_one_month_from_now
    return if expires_on_is_at_least_one_month_from_now?

    errors.add :expires_on, :at_least_one_month_from_now
  end

  def expires_on_is_at_least_one_month_from_now?
    expires_on && 1.month.from_now <= expires_on
  end

  def titleize_attributes
    self.title = title.titleize
    self.skills = skills.titleize
    self.position = position.titleize
    self.location = location.titleize
  end
end
