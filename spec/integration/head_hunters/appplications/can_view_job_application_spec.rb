# frozen_string_literal: true

require 'rails_helper'

feature 'Head Hunter can browse job applications' do
  context 'when logged-in' do
    let!(:head_hunter) { log_head_hunter_in! }

    scenario 'successfully' do
      job_a = create :job, head_hunter: head_hunter
      applicant = create :job_seeker
      create :job_seeker_profile, job_seeker: applicant
      application = create :job_application, job: job_a, job_seeker: applicant

      visit root_path
      click_on I18n.t('activerecord.models.job.other')
      within "tr#job-#{job_a.id}" do
        click_on I18n.t('views.navigation.details')
      end
      within "dd#application-#{application.id}" do
        click_on I18n.t('views.navigation.letter')
      end

      expect(current_path).to eq head_hunters_job_application_path(job_a, application)
      expect(page).to have_content applicant.resolve_name
      expect(page).to have_content application.cover_letter
    end

    scenario 'and return to jobs page' do
      job_a = create :job, head_hunter: head_hunter
      applicant = create :job_seeker
      create :job_seeker_profile, job_seeker: applicant
      application = create :job_application, job: job_a, job_seeker: applicant

      visit root_path
      click_on I18n.t('activerecord.models.job.other')
      within "tr#job-#{job_a.id}" do
        click_on I18n.t('views.navigation.details')
      end
      within "dd#application-#{application.id}" do
        click_on I18n.t('views.navigation.letter')
      end
      click_on I18n.t('views.navigation.go_back')

      expect(current_path).to eq head_hunters_job_path(job_a)
    end

    scenario "and gets redirected when accessing another's job application" do
      job_a = create :job
      applicant = create :job_seeker
      application = create :job_application, job: job_a, job_seeker: applicant

      visit head_hunters_job_application_path job_a, application

      expect(current_path).to eq head_hunters_jobs_path
      expect(page).to have_content I18n.t 'flash.unauthorized'

      page.driver.post head_hunters_job_application_standout_path job_a, application
      visit page.driver.response.location

      expect(current_path).to eq head_hunters_jobs_path
      expect(page).to have_content I18n.t 'flash.unauthorized'
    end
  end
end
