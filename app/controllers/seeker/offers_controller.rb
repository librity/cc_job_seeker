# frozen_string_literal: true

module Seeker
  class OffersController < BaseController
    skip_before_action :verify_authenticity_token, only: %i[accept reject]

    before_action :check_job_seeker, only: %i[show accept reject]
    before_action :check_status, only: %i[accept reject]
    before_action :reject_ongoing_offers, only: %i[accept]

    def index
      @offers = current_job_seeker.offers
    end

    def show; end

    def accept
      @offer.accept! params[:feedback]

      flash[:success] = t 'flash.offer_accepted'
      redirect_to request.referer
    end

    def reject
      @offer.reject! params[:feedback]

      flash[:success] = t 'flash.offer_rejected'
      redirect_to request.referer
    end

    private

    def check_job_seeker
      @offer = Job::Application::Offer.find params[:id] || params[:offer_id]
      return if @offer.job_seeker == current_job_seeker

      flash[:danger] = t 'flash.unauthorized'
      redirect_to seeker_offers_path
    end

    def check_status
      return if @offer.ongoing?

      flash[:danger] = t 'flash.closed_offer'
      redirect_to seeker_offer_path(@offer)
    end

    def reject_ongoing_offers
      @ongoing_offers = current_job_seeker.offers.ongoing
      @rejected_offers = @ongoing_offers.filter { |offer| offer != @offer }
      @rejected_offers.each(&:reject_with_default_feedback!)
    end
  end
end
