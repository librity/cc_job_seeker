# frozen_string_literal: true

require 'rails_helper'

describe 'Logged-out Job Seeker' do
  scenario 'gets redirected when trying to create a profile' do
    post job_seekers_profiles_path

    expect(response).to redirect_to(new_job_seeker_session_path)
  end
end
