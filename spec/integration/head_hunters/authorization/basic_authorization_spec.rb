# frozen_string_literal: true

require 'rails_helper'

feature 'Head Hunter browses' do
  scenario "application and links to resources don't appear unless logged-in" do
    visit root_path

    expect(page).not_to have_link I18n.t('views.actions.log_out'),
                                  href: destroy_head_hunter_session_path

    expect(page).to have_link I18n.t('views.navigation.log_in'),
                              href: new_head_hunter_session_path
    expect(page).to have_link I18n.t('views.navigation.create_account'),
                              href: new_head_hunter_registration_path
  end

  scenario 'application and links to resources appear when logged-in' do
    log_head_hunter_in!

    visit root_path

    expect(page).to have_link I18n.t('views.actions.log_out'),
                              href: destroy_head_hunter_session_path

    expect(page).not_to have_link I18n.t('views.navigation.log_in'),
                                  href: new_head_hunter_session_path
    expect(page).not_to have_link I18n.t('views.navigation.create_account'),
                                  href: new_head_hunter_registration_path

    expect(page).to have_link I18n.t('activerecord.models.job.other'),
                              href: head_hunters_jobs_path
  end

  scenario "application and can't access dashboard unless logged in" do
    visit head_hunters_dashboard_path

    expect(current_path).to eq new_head_hunter_session_path

    expect(page).to have_link I18n.t('views.navigation.log_in'),
                              href: new_head_hunter_session_path
    expect(page).to have_link I18n.t('views.navigation.create_account'),
                              href: new_head_hunter_registration_path

    expect(page).not_to have_link I18n.t('views.actions.log_out'),
                                  href: destroy_head_hunter_session_path
  end

  context 'jobs' do
    scenario 'successfully' do
      log_head_hunter_in!

      visit head_hunters_jobs_path
      expect(current_path).to eq head_hunters_jobs_path
    end

    scenario 'and gets redirected to log in view if not logged-in' do
      visit head_hunters_jobs_path
      expect(current_path).to eq new_head_hunter_session_path

      visit new_head_hunters_job_path
      expect(current_path).to eq new_head_hunter_session_path

      visit head_hunters_job_path(1)
      expect(current_path).to eq new_head_hunter_session_path

      # visit edit_head_hunters_job_path(1)
      # expect(current_path).to eq new_head_hunter_session_path
    end
  end
end
