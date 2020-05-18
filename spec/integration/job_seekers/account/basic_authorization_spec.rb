# frozen_string_literal: true

require 'rails_helper'

feature 'Job Seeker browses' do
  scenario "application and links to resources don't appear unless logged-in" do
    visit root_path

    expect(page).not_to have_link I18n.t('views.actions.log_out'),
                                  href: destroy_job_seeker_session_path

    expect(page).to have_link I18n.t('views.navigation.log_in'),
                              href: new_job_seeker_session_path
    expect(page).to have_link I18n.t('views.navigation.create_account'),
                              href: new_job_seeker_registration_path
  end

  scenario 'application and links to resources appear when logged-in' do
    log_job_seeker_in!

    visit root_path

    expect(page).to have_link I18n.t('views.actions.log_out'),
                              href: destroy_job_seeker_session_path

    expect(page).not_to have_link I18n.t('views.navigation.log_in'),
                                  href: new_job_seeker_session_path
    expect(page).not_to have_link I18n.t('views.navigation.create_account'),
                                  href: new_job_seeker_registration_path

    expect(page).to have_link I18n.t('activerecord.models.job_seeker/profile.my_profile'),
                              href: job_seekers_show_profile_path
  end

  scenario "application and can't access dashboard unless logged in" do
    visit job_seekers_dashboard_path

    expect(current_path).to eq new_job_seeker_session_path

    expect(page).to have_link I18n.t('views.navigation.log_in'),
                              href: new_job_seeker_session_path
    expect(page).to have_link I18n.t('views.navigation.create_account'),
                              href: new_job_seeker_registration_path

    expect(page).not_to have_link I18n.t('views.actions.log_out'),
                                  href: destroy_job_seeker_session_path
  end

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

      page.driver.post job_seekers_profiles_path
      visit page.driver.response.location
      expect(current_path).to eq new_job_seeker_session_path

      visit job_seekers_edit_profile_path
      expect(current_path).to eq new_job_seeker_session_path
    end
  end
end
