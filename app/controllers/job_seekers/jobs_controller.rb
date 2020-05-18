# frozen_string_literal: true

module JobSeekers
  class JobsController < BaseController
    def index
      @jobs = Job.active
    end

    def show
      @job = Job.find params[:id]
      render :index unless @job.active?
    end
  end
end
