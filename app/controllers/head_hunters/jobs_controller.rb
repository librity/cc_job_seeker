# frozen_string_literal: true

module HeadHunters
  class JobsController < BaseController
    def index
      @jobs = current_head_hunter.jobs
    end

    def show
      @job = Job.find params[:id]
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
        redirect_to head_hunters_job_path @job
      else
        render :new
      end
    end

    private

    def job_params
      params.require(:job).permit :position, :title, :description, :skills,
                                  :salary_floor, :salary_roof, :location, :expires_on
    end
  end
end
