# frozen_string_literal: true

module Hunter
  class JobsController < BaseController
    before_action :check_head_hunter, only: %i[show retire]

    def index
      @jobs = current_head_hunter.jobs
    end

    def show
      @applications = @job.ongoing_applications
    end

    def new
      @job = Job.new
    end

    def create
      @job = Job.new job_params
      @job.head_hunter = current_head_hunter
      if @job.save
        flash[:success] = t 'flash.created',
                            resource: t('activerecord.models.job.one')
        redirect_to hunter_job_path @job
      else
        render :new
      end
    end

    def retire
      @job.retire!

      flash[:success] = t 'flash.job_retired'
      redirect_to hunter_job_path @job
    end

    private

    def job_params
      params.require(:job).permit :position, :title, :description, :skills,
                                  :salary_floor, :salary_roof, :location, :expires_on
    end

    def check_head_hunter
      @job = Job.find params[:id] || params[:job_id]
      return if @job.head_hunter == current_head_hunter

      flash[:danger] = t 'flash.unauthorized'
      redirect_to hunter_jobs_path
    end
  end
end
