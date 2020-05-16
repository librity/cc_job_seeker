# frozen_string_literal: true

module HeadHunters
  class JobsController < BaseController
    def index
      @jobs = current_head_hunter.jobs
    end

    def show
      @job = Job.find params[:id]
    end
  end
end
