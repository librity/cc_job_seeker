# frozen_string_literal: true

module HeadHunters
  class ApplicationsController < BaseController
    def show
      @job = Job.find params[:job_id]
      @application = @job.applications.find params[:id]
      @applicant = @application.job_seeker
    end
  end
end
