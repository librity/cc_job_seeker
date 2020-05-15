# frozen_string_literal: true

module HeadHunters
  class JobsController < BaseController
    def index
      @jobs = Job.by_head_hunter current_head_hunter
    end
  end
end
