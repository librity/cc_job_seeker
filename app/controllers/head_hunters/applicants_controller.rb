# frozen_string_literal: true

module HeadHunters
  class ApplicantsController < BaseController
    def show
      @job = Job.find params[:job_id]
      @applicant = @job.applicants.find params[:id]
      @profile = @applicant.profile
    end
  end
end
