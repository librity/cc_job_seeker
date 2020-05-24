# frozen_string_literal: true

module Hunter
  class ApplicationsController < BaseController
    before_action :check_head_hunter, except: %i[index]

    def index
      @applications = current_head_hunter.applications.ongoing
    end

    def show
      @applicant = @application.job_seeker
    end

    def standout
      @application.update standout: @application.standout.!
      redirect_to request.referer
    end

    def rejection; end

    def reject
      if @application.update rejection_params
        flash[:success] = t 'flash.application_rejected'
        redirect_to hunter_applications_path
      else
        render :rejection
      end
    end

    private

    def rejection_params
      params.require(:job_application).permit :rejection_feedback
    end

    def check_head_hunter
      @application = Job::Application.find params[:id] || params[:application_id]
      return if @application.head_hunter == current_head_hunter

      flash[:danger] = t 'flash.unauthorized'
      redirect_to hunter_applications_path
    end
  end
end
