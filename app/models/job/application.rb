# frozen_string_literal: true

class Job
  class Application < ActiveRecord::Base
    belongs_to :job
    belongs_to :job_seeker

    has_many :offers, dependent: :destroy, class_name: Job::Application::Offer.name,
                      foreign_key: 'job_application_id'

    validates :job_seeker, presence: true
    validates :job, presence: true
    validates :cover_letter, presence: true, length: { minimum: 50 }
    validates :rejection_feedback, allow_nil: true, allow_blank: false,
                                   length: { minimum: 50 }

    def rejected?
      rejection_feedback.present?
    end

    def status
      return Job::Application.human_attribute_name 'status.rejected' if rejected?

      Job::Application.human_attribute_name 'status.ongoing'
    end
  end
end
