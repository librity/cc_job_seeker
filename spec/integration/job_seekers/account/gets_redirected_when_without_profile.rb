# frozen_string_literal: true

require 'rails_helper'

feature 'Job Seeker can signup' do
  scenario "and gets redirected to profile creation if it hasn't created one yet" do
    job_seeker = build :job_seeker

    visit root_path
    within 'li#job_seekers_dropdown' do
      click_on I18n.t('views.navigation.create_account')
    end

    fill_in I18n.t('activerecord.attributes.job_seeker.name'), with: job_seeker.name
    fill_in I18n.t('activerecord.attributes.job_seeker.email'), with: job_seeker.email
    fill_in I18n.t('activerecord.attributes.job_seeker.password'), with: job_seeker.password
    fill_in I18n.t('activerecord.attributes.job_seeker.password_confirmation'), with: job_seeker.password
    within 'form' do
      click_on I18n.t('views.actions.sign_up')
    end

    expect(current_path).to eq new_job_seekers_profile_path
    expect(page).to have_content I18n.t('views.messages.fill_out_to_finish')
    click_on I18n.t('views.actions.log_out')

    expect(current_path).to eq root_path
    within 'li#job_seekers_dropdown' do
      click_on I18n.t('views.navigation.log_in')
    end
    expect(current_path).to eq new_job_seeker_session_path

    fill_in I18n.t('activerecord.attributes.job_seeker.email'), with: job_seeker.email
    fill_in I18n.t('activerecord.attributes.job_seeker.password'), with: job_seeker.password
    within 'form' do
      click_on I18n.t('views.actions.log_in')
    end

    expect(current_path).to eq new_job_seekers_profile_path
    expect(page).to have_content I18n.t('views.messages.fill_out_to_finish')
  end
end
