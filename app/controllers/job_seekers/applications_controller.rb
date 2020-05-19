# frozen_string_literal: true

module JobSeekers
  class ApplicationsController < BaseController
    before_action :check_active_job, only: %i[new create]
    before_action :check_if_already_applied, only: %i[new create]

    def index
      @applications = current_job_seeker.applications
    end

    def new
      @application = Job::Application.new
    end

    def create
      @application = build_application

      if @application.save
        flash[:success] = t 'flash.created',
                            resource: t('activerecord.models.job/application.one')
        redirect_to job_seekers_jobs_path
      else
        render :new
      end
    end

    private

    def build_application
      application = Job::Application.new application_params
      application.job = @job
      application.job_seeker = current_job_seeker
      application
    end

    def application_params
      params.require(:job_application).permit :cover_letter
    end

    def check_active_job
      @job = Job.find params[:job_id]
      return if @job.active?

      flash[:danger] = t 'flash.inactive_job'
      redirect_to job_seekers_jobs_path
    end

    def check_if_already_applied
      return unless current_job_seeker.already_applied? params[:job_id]

      flash[:danger] = t 'flash.already_applied'
      redirect_to job_seekers_job_path(@job)
    end
  end
end
