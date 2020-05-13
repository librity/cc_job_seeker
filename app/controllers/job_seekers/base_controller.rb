# frozen_string_literal: true

module JobSeekers
  class BaseController < ApplicationController
    before_action :authenticate_job_seeker!
  end
end
