# frozen_string_literal: true

class JobSeeker
  class Profile < ActiveRecord::Base
    belongs_to :job_seeker

    has_one_attached :avatar

    validates :job_seeker, presence: true
    validates :bio, presence: true, length: { minimum: 50 }
    validates :interests, presence: true
    validates :high_school, presence: true
    validates :avatar, presence: true
    VALID_DATE_REGEX = /\d{4}-\d{2}-\d{2}/.freeze
    validates :date_of_birth, presence: true, format: { with: VALID_DATE_REGEX }
    validate :whether_job_seeker_is_at_least_sixteen

    private

    def whether_job_seeker_is_at_least_sixteen
      return if date_of_birth_is_at_least_sixteen_years_ago?

      errors.add :date_of_birth, :at_least_sixteen_years_ago
    end

    def date_of_birth_is_at_least_sixteen_years_ago?
      date_of_birth && date_of_birth <= 16.years.ago
    end
  end
end
