# frozen_string_literal: true

require 'rails_helper'

feature 'Job Seeker can apply to an active job' do
  context 'when logged-in' do
    let!(:job_seeker) { log_job_seeker_in! }

    scenario 'successfully' do
      Faker::Job.unique.clear

      job_a = create :job
      application = build :job_application

      visit root_path
      click_on I18n.t('activerecord.models.job.other')
      within "tr#job-#{job_a.id}" do
        click_on I18n.t('views.navigation.details')
      end
      click_on I18n.t('views.navigation.apply')

      expect(current_path).to eq new_job_seekers_job_application_path(job_a)
      fill_in I18n.t('activerecord.attributes.job/application.cover_letter'),
              with: application.cover_letter
      click_on I18n.t('views.actions.send')

      expect(job_a.applications.count).to eq 1
      expect(current_path).to eq job_seekers_jobs_path
      expect(page).to have_content I18n.t('flash.created',
                                          resource: I18n.t('activerecord.models.job/application.one'))

      click_on I18n.t('views.navigation.my_applications')

      expect(current_path).to eq job_seekers_applications_path
      expect(page).to have_content job_a.title
      expect(page).to have_content application.cover_letter
    end

    scenario "can't apply to the same job twice" do
      Faker::Job.unique.clear

      job_a = create :job
      create :job_application, job_seeker: job_seeker, job: job_a

      visit root_path
      click_on I18n.t('activerecord.models.job.other')
      within "tr#job-#{job_a.id}" do
        click_on I18n.t('views.navigation.details')
      end

      expect(page).not_to have_content I18n.t('views.navigation.apply')
    end
  end
end
