# frozen_string_literal: true

module Accessible
  extend ActiveSupport::Concern
  included do
    prepend_before_action :check_user
  end

  protected

  def check_user
    return redirect_head_hunter! if current_head_hunter
    return redirect_job_seeker! if current_job_seeker
  end

  private

  def redirect_head_hunter!
    flash.clear
    flash[:danger] = t 'views.messages.cross_model_access'

    redirect_to(head_hunters_dashboard_path) && return
  end

  def redirect_job_seeker!
    flash.clear
    flash[:danger] = t 'views.messages.cross_model_access'

    redirect_to(job_seekers_dashboard_path) && return
  end
end
