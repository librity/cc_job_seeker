# frozen_string_literal: true

require 'rails_helper'

feature 'Logged in Job Seeker' do
  before :each do
    log_job_seeker_in!
  end

  scenario "can't log in as Head Hunter" do
    visit new_head_hunter_session_path

    expect(current_path).to eq seeker_dashboard_path
    expect(page).to have_content I18n.t('flash.cross_model_access')
  end

  scenario "can't sign up as Head Hunter" do
    visit new_head_hunter_registration_path

    expect(current_path).to eq seeker_dashboard_path
    expect(page).to have_content I18n.t('flash.cross_model_access')
  end
end
