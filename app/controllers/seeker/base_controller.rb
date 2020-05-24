# frozen_string_literal: true

module Seeker
  class BaseController < ApplicationController
    before_action :authenticate_job_seeker!
    before_action :check_profile

    private

    def check_profile
      redirect_to new_seeker_profile_path unless current_job_seeker.profile?
    end
  end
end
