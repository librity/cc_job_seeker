# frozen_string_literal: true

require 'rails_helper'

feature 'Head Hunter can browse job applicants' do
  context 'when logged-in' do
    let!(:head_hunter) { log_head_hunter_in! }

    scenario 'successfully' do
      Faker::Job.unique.clear

      job_a = create :job, head_hunter: head_hunter
      create :job_application, job: job_a
      create :job_application, job: job_a
      create :job_application, job: job_a

      job_b = create :job, head_hunter: head_hunter
      create :job_application, job: job_b
      create :job_application, job: job_b
      create :job_application, job: job_b

      visit root_path
      click_on I18n.t('activerecord.models.job.other')
      within "tr#job-#{job_a.id}" do
        click_on I18n.t('views.navigation.details')
      end

      job_a.applicants.each do |applicant|
        expect(page).to have_link applicant.resolve_name,
                                  href: head_hunters_job_applicant_path(job_a, applicant)
      end

      job_b.applicants.each do |applicant|
        expect(page).not_to have_content applicant.resolve_name
      end
    end

    scenario 'and view profile' do
      job_a = create :job, head_hunter: head_hunter
      applicant = create :job_seeker
      create :job_seeker_profile, job_seeker: applicant
      create :job_application, job: job_a, job_seeker: applicant

      visit root_path
      click_on I18n.t('activerecord.models.job.other')
      within "tr#job-#{job_a.id}" do
        click_on I18n.t('views.navigation.details')
      end
      click_on applicant.resolve_name

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

    scenario 'and job has no applications' do
      job_a = create :job, head_hunter: head_hunter

      visit root_path
      click_on I18n.t('activerecord.models.job.other')
      within "tr#job-#{job_a.id}" do
        click_on I18n.t('views.navigation.details')
      end

      expect(page).to have_content I18n.t('views.job_seeker/applications.empty_resource')
    end

    scenario 'and return to jobs page' do
      job_a = create :job, head_hunter: head_hunter
      applicant = create :job_seeker
      create :job_seeker_profile, job_seeker: applicant
      create :job_application, job: job_a, job_seeker: applicant

      visit root_path
      click_on I18n.t('activerecord.models.job.other')
      within "tr#job-#{job_a.id}" do
        click_on I18n.t('views.navigation.details')
      end
      click_on applicant.resolve_name
      click_on I18n.t('views.navigation.go_back')

      expect(current_path).to eq head_hunters_job_path(job_a)
    end
  end
end
