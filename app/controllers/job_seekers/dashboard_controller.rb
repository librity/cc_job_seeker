# frozen_string_literal: true

module JobSeekers
  class DashboardController < BaseController
    def index
      redirect_to new_job_seekers_profile_path unless current_job_seeker.profile?
    end
  end
end
