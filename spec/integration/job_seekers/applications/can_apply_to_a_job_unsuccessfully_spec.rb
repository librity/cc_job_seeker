# frozen_string_literal: true

require 'rails_helper'

feature 'Job Seeker can apply to an active job' do
  context 'when logged-in' do
    let!(:job_seeker) { log_job_seeker_in! }

    scenario 'and must fill required fields' do
      Faker::Job.unique.clear
      job_a = create :job

      visit root_path
      click_on I18n.t('views.navigation.browse_jobs')
      within "tr#job-#{job_a.id}" do
        click_on I18n.t('views.navigation.details')
      end
      click_on I18n.t('views.navigation.apply')

      expect(current_path).to eq new_job_seekers_job_application_path(job_a)
      fill_in I18n.t('activerecord.attributes.job/application.cover_letter'),
              with: ' '
      click_on I18n.t('views.actions.send')

      expect(page).to have_content I18n.t('errors.messages.blank'), count: 1
    end

    scenario 'and cover letter must be at least 50 characters' do
      Faker::Job.unique.clear
      job_a = create :job

      visit root_path
      click_on I18n.t('views.navigation.browse_jobs')
      within "tr#job-#{job_a.id}" do
        click_on I18n.t('views.navigation.details')
      end
      click_on I18n.t('views.navigation.apply')

      expect(current_path).to eq new_job_seekers_job_application_path(job_a)
      fill_in I18n.t('activerecord.attributes.job/application.cover_letter'),
              with: 'a' * 49
      click_on I18n.t('views.actions.send')

      expect(page).to have_content I18n.t('errors.messages.too_short', count: 50)
    end

    scenario "can't apply to an inactive job" do
      Faker::Job.unique.clear

      job_a = create :job, :skip_validate, :expired
      job_b = create :job, retired: true
      create :job_application, job_seeker: job_seeker, job: job_a

      visit root_path
      click_on I18n.t('views.navigation.browse_jobs')

      expect(page).not_to have_content job_a.title
      expect(page).not_to have_content job_b.title

      visit new_job_seekers_job_application_path(job_a)
      expect(current_path).to eq job_seekers_jobs_path
      expect(page).to have_content I18n.t 'flash.inactive_job'

      visit new_job_seekers_job_application_path(job_b)
      expect(current_path).to eq job_seekers_jobs_path
      expect(page).to have_content I18n.t 'flash.inactive_job'
    end

    scenario "can't apply to the same job twice" do
      Faker::Job.unique.clear

      job_a = create :job
      create :job_application, job_seeker: job_seeker, job: job_a

      visit root_path
      click_on I18n.t('views.navigation.browse_jobs')
      within "tr#job-#{job_a.id}" do
        click_on I18n.t('views.navigation.details')
      end

      expect(page).not_to have_content I18n.t('views.navigation.apply')

      visit new_job_seekers_job_application_path(job_a)

      expect(current_path).to eq job_seekers_job_path(job_a)
      expect(page).to have_content I18n.t 'flash.already_applied'
    end
  end
end
