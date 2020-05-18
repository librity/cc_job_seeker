# frozen_string_literal: true

require 'rails_helper'

feature 'Job Seekers' do
  scenario 'can change their password' do
    job_seeker = log_job_seeker_in!

    visit root_path
    within 'li#account_dropdown' do
      click_on I18n.t('views.navigation.change_password')
    end

    new_password = Faker::Internet.password min_length: 8

    fill_in I18n.t('activerecord.attributes.job_seeker.password'), with: new_password
    fill_in I18n.t('activerecord.attributes.job_seeker.password_confirmation'), with: new_password
    fill_in I18n.t('activerecord.attributes.job_seeker.current_password'), with: job_seeker.password
    within 'form#edit_job_seeker' do
      click_on I18n.t('views.actions.update')
    end

    expect(page).to have_content I18n.t('devise.registrations.updated')
    click_on I18n.t('views.actions.log_out')
    within 'li#job_seekers_dropdown' do
      click_on I18n.t('views.navigation.log_in')
    end

    fill_in I18n.t('activerecord.attributes.job_seeker.email'), with: job_seeker.email
    fill_in I18n.t('activerecord.attributes.job_seeker.password'), with: new_password
    within 'form' do
      click_on I18n.t('views.actions.log_in')
    end

    expect(page).to have_content I18n.t('devise.sessions.signed_in')
    expect(current_path).to eq job_seekers_dashboard_path
  end
end
