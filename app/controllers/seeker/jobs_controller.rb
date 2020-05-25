# frozen_string_literal: true

module Seeker
  class JobsController < BaseController
    before_action :check_active_job, only: %i[show]

    def index
      if params[:search]
        search_jobs
      else
        @jobs = Job.active
      end
    end

    def show; end

    private

    def search_jobs
      @jobs = Job.active.by_title_or_description params[:search]
      return unless @jobs.empty?

      @jobs = Job.active
      flash.now[:info] = t 'flash.job_not_found'
    end

    def check_active_job
      @job = Job.find params[:id]
      return if @job.active?

      flash[:danger] = t 'flash.inactive_job'
      redirect_to seeker_jobs_path
    end
  end
end
