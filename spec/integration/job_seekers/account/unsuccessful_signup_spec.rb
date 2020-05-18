# frozen_string_literal: true

require 'rails_helper'

feature 'Job Seeker can signup' do
  scenario 'and must fill in all fields' do
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

    within 'form' do
      click_on I18n.t('views.actions.send')
    end

    expect(page).to have_content I18n.t('errors.messages.blank'), count: 4
  end

  scenario 'and description should be at least 50 characters long' do
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

    fill_in I18n.t('activerecord.attributes.job_seeker/profile.description'), with: 'a' * 49
    within 'form' do
      click_on I18n.t('views.actions.send')
    end

    expect(page).to have_content I18n.t('errors.messages.too_short', count: 50)
  end

  scenario 'and date of birth must be valid' do
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

    fill_in I18n.t('activerecord.attributes.job_seeker/profile.date_of_birth'), with: 'dsa211$'
    within 'form' do
      click_on I18n.t('views.actions.send')
    end

    expect(page).to have_content I18n.t('errors.messages.invalid'), count: 1
  end

  scenario 'and date of birth must be at least 16 years ago' do
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

    fill_in I18n.t('activerecord.attributes.job_seeker/profile.date_of_birth'), with: 15.years.ago
    within 'form' do
      click_on I18n.t('views.actions.send')
    end

    expect(page).to have_content I18n
      .t('activerecord.errors.models.job_seeker/profile.attributes.date_of_birth.at_least_sixteen_years_ago')
  end
end
