# frozen_string_literal: true

module Hunter
  class ApplicantsController < BaseController
    before_action :check_profile, only: %i[show comment]

    def index
      @applicants = current_head_hunter.applicants.uniq
    end

    def show
      @comment = JobSeeker::Profile::Comment.new
    end

    def comment
      @comment = build_comment

      if @comment.save
        flash[:success] = t 'flash.created',
                            resource: t('activerecord.models.job_seeker/profile/comment.one')
        redirect_to request.referer
      else
        render :show
      end
    end

    private

    def comment_params
      params.require(:job_seeker_profile_comment).permit :content
    end

    def build_comment
      comment = JobSeeker::Profile::Comment.new comment_params
      comment.profile = @profile
      comment.head_hunter = current_head_hunter
      comment
    end

    def check_profile
      @applicant = JobSeeker.find params[:id] || params[:applicant_id]
      @profile = @applicant.profile
      return if @profile

      flash[:danger] = t 'flash.profile_not_found'
      redirect_to hunter_applicants_path
    end
  end
end
