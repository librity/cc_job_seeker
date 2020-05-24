# frozen_string_literal: true

module Hunter
  class OffersController < BaseController
    before_action :resolve_job, :check_head_hunter, except: :index

    def index
      @offers = current_head_hunter.offers
    end

    def show; end

    def new
      @offer = Job::Application::Offer.new
    end

    def create
      @offer = Job::Application::Offer.new offer_params
      @offer.application = @application
      @offer.head_hunter = current_head_hunter

      if @offer.save
        flash[:success] = t 'flash.created',
                            resource: t('activerecord.models.job/application/offer.one')
        redirect_to hunter_offer_path @offer
      else
        render :new
      end
    end

    private

    def offer_params
      params.require(:job_application_offer).permit :start_date, :salary, :responsabilities,
                                                    :benefits, :expectations, :bonus
    end

    def resolve_job
      if params[:application_id]
        @application = Job::Application.find params[:application_id]
        @job = @application.job
      else
        @offer = Job::Application::Offer.find params[:id]
        @job = @offer.job
      end
    end

    def check_head_hunter
      return if @job.head_hunter == current_head_hunter

      flash[:danger] = t 'flash.unauthorized'
      redirect_to hunter_offers_path
    end
  end
end
