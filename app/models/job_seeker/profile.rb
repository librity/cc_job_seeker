# frozen_string_literal: true

class JobSeeker
  class Profile < ActiveRecord::Base
    has_one_attached :avatar

    belongs_to :job_seeker

    has_many :comments, dependent: :destroy, class_name: JobSeeker::Profile::Comment.name,
                        foreign_key: 'job_seeker_profile_id'
    has_many :favorites, dependent: :destroy, class_name: JobSeeker::Profile::Favorite.name,
                         foreign_key: 'job_seeker_profile_id'

    validates :job_seeker, presence: true
    validates :bio, presence: true, length: { minimum: 50 }
    validates :interests, presence: true
    validates :high_school, presence: true
    validates :avatar, presence: true
    validates :date_of_birth, presence: true, format: { with: ApplicationHelper::DATE_REGEX }
    validate :whether_theyre_at_least_sixteen

    private

    def whether_theyre_at_least_sixteen
      return if date_of_birth_is_at_least_sixteen_years_ago?

      errors.add :date_of_birth, :under_sixteen
    end

    def date_of_birth_is_at_least_sixteen_years_ago?
      date_of_birth && date_of_birth <= 16.years.ago
    end
  end
end
