# frozen_string_literal: true

require 'rails_helper'

feature 'Job Seeker logs in' do
  scenario 'successfully' do
    job_seeker = job_seeker_with_profile

    visit root_path

    within 'li#seeker_dropdown' do
      click_on I18n.t('views.navigation.log_in')
    end

    expect(current_path).to eq new_job_seeker_session_path

    fill_in I18n.t('activerecord.attributes.job_seeker.email'), with: job_seeker.email
    fill_in I18n.t('activerecord.attributes.job_seeker.password'), with: job_seeker.password
    within 'form' do
      click_on I18n.t('views.actions.log_in')
    end

    expect(page).to have_content I18n.t('devise.sessions.signed_in')

    expect(page).to have_link I18n.t('views.actions.log_out'),
                              href: destroy_job_seeker_session_path
    expect(page).not_to have_link I18n.t('views.navigation.log_in'),
                                  href: new_job_seeker_session_path
    expect(page).not_to have_link I18n.t('views.navigation.create_account'),
                                  href: new_job_seeker_registration_path

    expect(current_path).to eq seeker_dashboard_path
  end

  scenario 'and must fill in all fields' do
    visit root_path
    within 'li#seeker_dropdown' do
      click_on I18n.t('views.navigation.log_in')
    end
    expect(current_path).to eq new_job_seeker_session_path

    within 'form' do
      click_on I18n.t('views.actions.log_in')
    end

    expect(page).to have_content I18n.t('devise.failure.invalid',
                                        authentication_keys: I18n.t('activerecord.attributes.job_seeker.email'))

    expect(page).not_to have_link I18n.t('views.actions.log_out'),
                                  href: destroy_job_seeker_session_path
    expect(page).to have_link I18n.t('views.navigation.log_in'),
                              href: new_job_seeker_session_path
    expect(page).to have_link I18n.t('views.navigation.create_account'),
                              href: new_job_seeker_registration_path
  end
end
