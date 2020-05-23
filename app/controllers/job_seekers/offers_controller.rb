# frozen_string_literal: true

module JobSeekers
  class OffersController < BaseController
    skip_before_action :verify_authenticity_token, only: %i[accept reject]

    before_action :check_job_seeker, only: %i[show accept reject]
    before_action :check_status, only: %i[accept reject]
    before_action :load_job_seekers_offers, only: %i[index accept]

    def index; end

    def show; end

    def accept
      @offer.update feedback: params[:feedback]
      @other_offers = @offers.filter { |offer| offer != @offer }
      @other_offers.each(&:rejected!)
      @offer.accepted!

      flash[:success] = t 'flash.offer_accepted'
      redirect_to request.referer
    end

    def reject
      @offer.update feedback: params[:feedback]
      @offer.rejected!

      flash[:success] = t 'flash.offer_rejected'
      redirect_to request.referer
    end

    private

    def check_job_seeker
      @offer = Job::Application::Offer.find params[:id] || params[:offer_id]
      return if @offer.job_seeker == current_job_seeker

      flash[:danger] = t 'flash.unauthorized'
      redirect_to job_seekers_offers_path
    end

    def check_status
      return if @offer.ongoing?

      flash[:danger] = t 'flash.closed_offer'
      redirect_to job_seekers_offer_path(@offer)
    end

    def load_job_seekers_offers
      @offers = current_job_seeker.offers
    end
  end
end
