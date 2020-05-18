# frozen_string_literal: true

require 'rails_helper'

feature 'Job Seeker browses' do
  context 'jobs' do
    scenario 'successfully' do
      log_job_seeker_in!

      visit job_seekers_jobs_path
      expect(current_path).to eq job_seekers_jobs_path
    end

    scenario 'and gets redirected to log in view if not logged-in' do
      visit job_seekers_jobs_path
      expect(current_path).to eq new_job_seeker_session_path

      visit job_seekers_job_path(1)
      expect(current_path).to eq new_job_seeker_session_path
    end
  end
end
