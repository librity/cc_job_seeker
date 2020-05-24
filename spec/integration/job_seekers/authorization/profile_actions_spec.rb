# frozen_string_literal: true

require 'rails_helper'

feature 'Job Seeker browses' do
  context 'profile' do
    scenario 'successfully' do
      log_job_seeker_in!

      visit job_seekers_show_profile_path
      expect(current_path).to eq job_seekers_show_profile_path
    end

    scenario 'and gets redirected to log in view if not logged-in' do
      visit job_seekers_show_profile_path
      expect(current_path).to eq new_job_seeker_session_path

      visit new_job_seekers_profile_path
      expect(current_path).to eq new_job_seeker_session_path

      visit job_seekers_edit_profile_path
      expect(current_path).to eq new_job_seeker_session_path
    end
  end
end
