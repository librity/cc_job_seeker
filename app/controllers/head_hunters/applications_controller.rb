# frozen_string_literal: true

module HeadHunters
  class ApplicationsController < BaseController
    before_action :check_head_hunter

    def show
      @job = Job.find params[:job_id]
      @application = @job.applications.find params[:id]
      @applicant = @application.job_seeker
    end

    def standout
      @application = @job.applications.find params[:application_id]
      @application.standout = !@application.standout
      @application.save
      redirect_to request.referer
    end

    private

    def check_head_hunter
      @job = Job.find params[:job_id]
      return if @job.head_hunter == current_head_hunter

      flash[:danger] = t 'flash.unauthorized'
      redirect_to head_hunters_jobs_path
    end
  end
end
