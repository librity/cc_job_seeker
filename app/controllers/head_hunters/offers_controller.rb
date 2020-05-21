# frozen_string_literal: true

module HeadHunters
  class OffersController < BaseController
    before_action :check_head_hunter, :load_dependencies

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
        redirect_to head_hunters_job_application_path @job, @application
      else
        render :new
      end
    end

    private

    def offer_params
      params.require(:job_application_offer).permit :start_date, :salary, :responsabilities,
                                                    :benefits, :expectations, :bonus
    end

    def check_head_hunter
      @job = Job.find params[:job_id]
      return if @job.head_hunter == current_head_hunter

      flash[:danger] = t 'flash.unauthorized'
      redirect_to head_hunters_jobs_path
    end

    def load_dependencies
      @application = @job.applications.find params[:application_id]
    end
  end
end
