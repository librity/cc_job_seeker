# frozen_string_literal: true

require 'rails_helper'

feature 'Job Seeker can edit their profile' do
  context 'when logged-in' do
    let!(:job_seeker) { log_job_seeker_in! }

    scenario 'successfully' do
      edited_profile = build :job_seeker_profile

      visit root_path
      click_on I18n.t('activerecord.models.job_seeker/profile.my_profile')
      click_on I18n.t('views.navigation.edit')

      attach_file I18n.t('activerecord.attributes.job_seeker/profile.avatar'), FileUploadSupport.jpg_path
      fill_in I18n.t('activerecord.attributes.job_seeker/profile.date_of_birth'),
              with: edited_profile.date_of_birth
      fill_in I18n.t('activerecord.attributes.job_seeker/profile.high_school'),
              with: edited_profile.high_school
      fill_in I18n.t('activerecord.attributes.job_seeker/profile.college'),
              with: edited_profile.college
      fill_in I18n.t('activerecord.attributes.job_seeker/profile.degrees'),
              with: edited_profile.degrees
      fill_in I18n.t('activerecord.attributes.job_seeker/profile.courses'),
              with: edited_profile.courses
      fill_in I18n.t('activerecord.attributes.job_seeker/profile.interests'),
              with: edited_profile.interests
      fill_in I18n.t('activerecord.attributes.job_seeker/profile.description'),
              with: edited_profile.description
      fill_in I18n.t('activerecord.attributes.job_seeker/profile.work_experience'),
              with: edited_profile.work_experience
      within 'form' do
        click_on I18n.t('views.actions.send')
      end

      expect(current_path).to eq job_seekers_show_profile_path

      expect(page).to have_content job_seeker.name
      expect(page).to have_content I18n.l(edited_profile.date_of_birth)
      expect(page).to have_content edited_profile.high_school
      expect(page).to have_content edited_profile.college
      expect(page).to have_content edited_profile.degrees
      expect(page).to have_content edited_profile.courses
      expect(page).to have_content edited_profile.interests
      expect(page).to have_content edited_profile.description
      expect(page).to have_content edited_profile.work_experience
      expect(page).to have_css 'img', count: 3
    end

    scenario 'and must fill required fields' do
      visit root_path
      click_on I18n.t('activerecord.models.job_seeker/profile.my_profile')
      click_on I18n.t('views.navigation.edit')

      fill_in I18n.t('activerecord.attributes.job_seeker/profile.description'),
              with: '   '
      fill_in I18n.t('activerecord.attributes.job_seeker/profile.interests'),
              with: '   '
      fill_in I18n.t('activerecord.attributes.job_seeker/profile.high_school'),
              with: '   '
      fill_in I18n.t('activerecord.attributes.job_seeker/profile.date_of_birth'),
              with: ' '
      click_on I18n.t('views.actions.send')

      expect(page).to have_content I18n.t('errors.messages.blank'), count: 4
    end
  end
end
