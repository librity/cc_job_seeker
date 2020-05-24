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
                              href: seeker_show_profile_path
    expect(page).to have_link I18n.t('activerecord.models.job.other'),
                              href: seeker_jobs_path
    expect(page).to have_link I18n.t('views.navigation.my_jobs'),
                              href: seeker_applications_path
  end

  scenario "application and can't access dashboard unless logged in" do
    visit seeker_dashboard_path

    expect(current_path).to eq new_job_seeker_session_path

    expect(page).to have_link I18n.t('views.navigation.log_in'),
                              href: new_job_seeker_session_path
    expect(page).to have_link I18n.t('views.navigation.create_account'),
                              href: new_job_seeker_registration_path

    expect(page).not_to have_link I18n.t('views.actions.log_out'),
                                  href: destroy_job_seeker_session_path
  end
end
