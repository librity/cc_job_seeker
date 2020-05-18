# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def after_sign_in_path_for resource
    return head_hunters_dashboard_path if resource.class.name == 'HeadHunter'
    return job_seekers_dashboard_path if resource.class.name == 'JobSeeker'
  end

  def after_sign_out_path_for _resource
    root_path
  end

  protected

  def devise_parameter_sanitizer
    if resource_class == HeadHunter
      HeadHunter::ParameterSanitizer.new HeadHunter, :head_hunter, params
    else
      JobSeeker::ParameterSanitizer.new JobSeeker, :job_seeker, params
    end
  end
end
