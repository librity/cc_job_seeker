# frozen_string_literal: true

module JobSeekers
  class ProfilesController < BaseController
    def new
      flash.clear
      flash[:info] = t 'views.messages.fill_out_to_finish'
      @profile = JobSeeker::Profile.new
    end

    def create
      @profile = JobSeeker::Profile.new profile_params
      @profile.job_seeker = current_job_seeker
      if @profile.save
        flash[:success] = t 'devise.registrations.signed_up'
        redirect_to job_seekers_dashboard_path
      else
        render :new
      end
    end

    private

    def profile_params
      params.require(:job_seeker_profile).permit :date_of_birth, :high_school,
                                                 :college, :degrees, :courses,
                                                 :interests, :description,
                                                 :work_experience, :avatar
    end
  end
end
