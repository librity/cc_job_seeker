# frozen_string_literal: true

module JobSeekers
  class OffersController < BaseController
    before_action :check_job_seeker, only: %i[show]

    def index
      @application_ids = Job::Application.where(job_seeker: current_job_seeker).ids
      @offers = Job::Application::Offer.where application: @application_ids
    end

    def show; end

    private

    def check_job_seeker
      @offer = Job::Application::Offer.find params[:id]
      return if @offer.job_seeker == current_job_seeker

      flash[:danger] = t 'flash.unauthorized'
      redirect_to job_seekers_offers_path
    end
  end
end
