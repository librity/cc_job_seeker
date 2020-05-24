# frozen_string_literal: true

require 'rails_helper'

feature 'Head Hunter can browse job applicants' do
  context 'when logged-in' do
    let!(:head_hunter) { log_head_hunter_in! }

    scenario 'successfully' do
      Faker::Job.unique.clear

      job = create :job, head_hunter: head_hunter
      applications = create_list :job_application, 3, job: job

      visit root_path
      click_on I18n.t('views.navigation.my_applicants')

      expect(current_path).to eq hunter_applicants_path
      applications.each do |application|
        expect(page).to have_content application.job_seeker.resolve_name
        expect(page).to have_link I18n.t('views.navigation.details'),
                                  href: hunter_applicant_path(application.job_seeker)
      end
    end

    scenario 'and view profile' do
      job = create :job, head_hunter: head_hunter
      applicant = create :job_seeker
      create :job_seeker_profile, job_seeker: applicant
      create :job_application, job: job, job_seeker: applicant

      visit root_path
      click_on I18n.t('views.navigation.my_applicants')
      within "tr#applicant-#{applicant.id}" do
        click_on I18n.t('views.navigation.details')
      end

      expect(current_path).to eq hunter_applicant_path(applicant)
      expect(page).to have_content applicant.resolve_name
      expect(page).to have_content I18n.l(applicant.profile.date_of_birth)
      expect(page).to have_content applicant.profile.high_school
      expect(page).to have_content applicant.profile.college
      expect(page).to have_content applicant.profile.degrees
      expect(page).to have_content applicant.profile.courses
      expect(page).to have_content applicant.profile.interests
      expect(page).to have_content applicant.profile.bio
      expect(page).to have_content applicant.profile.work_experience
      expect(page).to have_css 'img', count: 3
    end
  end
end
