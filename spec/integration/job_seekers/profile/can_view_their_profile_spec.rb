# frozen_string_literal: true

require 'rails_helper'

feature 'Job Seeker can view their profile' do
  context 'when logged-in' do
    let!(:job_seeker) { log_job_seeker_in! }

    scenario 'successfully' do
      visit root_path
      expect(page).to have_css 'img', count: 2

      click_on I18n.t('activerecord.models.job_seeker/profile.my_profile')
      expect(current_path).to eq job_seekers_show_profile_path

      expect(page).to have_content job_seeker.name
      expect(page).to have_content I18n.l(job_seeker.profile.date_of_birth)
      expect(page).to have_content job_seeker.profile.high_school
      expect(page).to have_content job_seeker.profile.college
      expect(page).to have_content job_seeker.profile.degrees
      expect(page).to have_content job_seeker.profile.courses
      expect(page).to have_content job_seeker.profile.interests
      expect(page).to have_content job_seeker.profile.bio
      expect(page).to have_content job_seeker.profile.work_experience
      expect(page).to have_css 'img', count: 3
    end

    scenario "and show job seekers's social name" do
      job_seeker.update social_name: Faker::Name.unique.name

      visit root_path
      click_on I18n.t('activerecord.models.job_seeker/profile.my_profile')

      expect(page).to have_content job_seeker.social_name
    end

    scenario 'and return to home page' do
      visit root_path
      click_on I18n.t('activerecord.models.job_seeker/profile.my_profile')
      click_on I18n.t('views.navigation.go_back')

      expect(current_path).to eq job_seekers_dashboard_path
    end
  end
end
