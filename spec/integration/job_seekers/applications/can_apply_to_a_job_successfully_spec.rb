# frozen_string_literal: true

require 'rails_helper'

feature 'Job Seeker can apply to an active job' do
  context 'when logged-in' do
    let!(:job_seeker) { log_job_seeker_in! }

    scenario 'successfully' do
      job_a = create :job
      application = build :job_application

      visit root_path
      click_on I18n.t('views.navigation.browse_jobs')
      within "tr#job-#{job_a.id}" do
        click_on I18n.t('views.navigation.details')
      end
      click_on I18n.t('views.navigation.apply')

      expect(current_path).to eq new_seeker_job_application_path(job_a)
      fill_in I18n.t('activerecord.attributes.job/application.cover_letter'),
              with: application.cover_letter
      click_on I18n.t('views.actions.send')

      expect(Job::Application.count).to eq 1
      application = Job::Application.last
      expect(job_a.applications.count).to eq 1

      expect(current_path).to eq seeker_jobs_path
      expect(page).to have_content I18n.t('flash.created',
                                          resource: I18n.t('activerecord.models.job/application.one'))

      click_on I18n.t('views.navigation.my_jobs')

      expect(current_path).to eq seeker_applications_path
      expect(page).to have_link job_a.title, href: seeker_job_path(job_a)
      expect(page).to have_link I18n.t('views.navigation.details'),
                                href: seeker_application_path(application)
      expect(page).to have_content application.status
      expect(page).to have_css('.active_dot', count: 2)
    end
  end
end
