# frozen_string_literal: true

class Job
  class Application < ActiveRecord::Base
    belongs_to :job
    belongs_to :job_seeker

    validates :job_seeker, presence: true
    validates :job, presence: true
    validates :cover_letter, presence: true, length: { minimum: 50 }
    validates :rejection_feedback, allow_nil: true, allow_blank: false,
                                   length: { minimum: 50 }

    def rejected?
      rejection_feedback.present?
    end
  end
end
