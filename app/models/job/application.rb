# frozen_string_literal: true

class Job
  class Application < ActiveRecord::Base
    belongs_to :job
    belongs_to :job_seeker

    validates :job_seeker, presence: true
    validates :job, presence: true
    validates :cover_letter, presence: true, length: { minimum: 50 }
  end
end
