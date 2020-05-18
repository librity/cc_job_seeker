# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    redirect_to head_hunters_dashboard_path if head_hunter_signed_in?
    redirect_to job_seekers_dashboard_path if job_seeker_signed_in?
  end
end
