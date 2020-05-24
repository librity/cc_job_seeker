# frozen_string_literal: true

require 'rails_helper'

feature 'Job Seeker can signup' do
  scenario "and gets redirected to profile creation if it hasn't created one yet" do
    job_seeker = build :job_seeker

    visit root_path
    within 'li#seeker_dropdown' do
      click_on I18n.t('views.navigation.create_account')
    end

    fill_in I18n.t('activerecord.attributes.job_seeker.name'), with: job_seeker.name
    fill_in I18n.t('activerecord.attributes.job_seeker.email'), with: job_seeker.email
    fill_in I18n.t('activerecord.attributes.job_seeker.password'), with: job_seeker.password
    fill_in I18n.t('activerecord.attributes.job_seeker.password_confirmation'), with: job_seeker.password
    within 'form' do
      click_on I18n.t('views.actions.sign_up')
    end

    expect(current_path).to eq new_seeker_profile_path
    expect(page).to have_content I18n.t('flash.fill_out_profile')
    click_on I18n.t('views.actions.log_out')

    expect(current_path).to eq root_path
    within 'li#seeker_dropdown' do
      click_on I18n.t('views.navigation.log_in')
    end
    expect(current_path).to eq new_job_seeker_session_path

    fill_in I18n.t('activerecord.attributes.job_seeker.email'), with: job_seeker.email
    fill_in I18n.t('activerecord.attributes.job_seeker.password'), with: job_seeker.password
    within 'form' do
      click_on I18n.t('views.actions.log_in')
    end

    expect(current_path).to eq new_seeker_profile_path
    expect(page).to have_content I18n.t('flash.fill_out_profile')
  end

  context 'and gets redirected to profile creation' do
    let!(:job_seeker) { log_job_seeker_in! with_profile: false }

    scenario 'if it tries to access other resources' do
      visit root_path
      click_on I18n.t('activerecord.models.job_seeker/profile.my_profile')

      expect(current_path).to eq new_seeker_profile_path
    end
  end
end
