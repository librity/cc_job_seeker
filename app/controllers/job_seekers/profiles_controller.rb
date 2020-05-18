# frozen_string_literal: true

module JobSeekers
  class ProfilesController < BaseController
    before_action :load_profile, only: %i[show edit update]
    before_action :check_profile, only: %i[new create]

    def show; end

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

    def edit; end

    def update
      if @profile.update profile_params
        flash[:success] = t 'views.messages.successfully.updated',
                            resource: t('activerecord.models.job_seeker/profile.one')
        redirect_to job_seekers_show_profile_path
      else
        render :edit
      end
    end

    private

    def profile_params
      params.require(:job_seeker_profile).permit :date_of_birth, :high_school,
                                                 :college, :degrees, :courses,
                                                 :interests, :bio, :avatar,
                                                 :work_experience
    end

    def load_profile
      @profile = current_job_seeker.profile
    end

    def check_profile
      redirect_to job_seekers_show_profile_path if current_job_seeker.profile?
    end
  end
end
