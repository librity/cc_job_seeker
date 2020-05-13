# frozen_string_literal: true

module DeviseSupport
  def log_head_hunter_in! head_hunter = create(:head_hunter)
    login_as head_hunter, scope: :head_hunter
    head_hunter
  end

  def log_job_seeker_in! job_seeker = create(:job_seeker)
    login_as job_seeker, scope: :job_seeker
    job_seeker
  end
end
