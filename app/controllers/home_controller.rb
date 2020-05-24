# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    redirect_to hunter_dashboard_path if head_hunter_signed_in?
    redirect_to seeker_dashboard_path if job_seeker_signed_in?
  end
end
