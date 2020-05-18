# frozen_string_literal: true

module JobSeekers
  class JobsController < BaseController
    def index
      if params[:search]
        search_jobs
      else
        @jobs = Job.active
      end
    end

    def show
      @job = Job.find params[:id]
      render :index unless @job.active?
    end

    private

    def search_jobs
      @jobs = Job.active.by_title_or_description params[:search]
      return unless @jobs.blank?

      @jobs = Job.active
      flash.now[:info] = t 'views.resources.jobs.not_found'
    end
  end
end
