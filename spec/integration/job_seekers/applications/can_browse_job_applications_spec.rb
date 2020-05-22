# frozen_string_literal: true

require 'rails_helper'

feature 'Job Seeker can browse their applications' do
  context 'when logged-in' do
    let!(:job_seeker) { log_job_seeker_in! }

    scenario 'successfully' do
      job_a = create :job
      application = create :job_application, job: job_a, job_seeker: job_seeker

      visit job_seekers_applications_path
      within "tr#application-#{application.id}" do
        click_on I18n.t('views.navigation.details')
      end

      expect(current_path).to eq job_seekers_application_path(application)
      expect(page).to have_content application.cover_letter
      expect(page).to have_content I18n.t('activerecord.attributes.job/application/status.ongoing')
      expect(page).to have_css('.ongoing_application', count: 1)
    end

    scenario 'and application was rejected' do
      job_a = create :job
      application = create :job_application, :rejected, job: job_a, job_seeker: job_seeker

      visit job_seekers_applications_path
      within "tr#application-#{application.id}" do
        click_on I18n.t('views.navigation.details')
      end

      expect(current_path).to eq job_seekers_application_path(application)
      expect(page).to have_content application.cover_letter
      expect(page).to have_content I18n.t('activerecord.attributes.job/application/status.rejected')
      expect(page).to have_content application.status
      expect(page).to have_content application.rejection_feedback
      expect(page).to have_css('.rejected_application', count: 1)
    end
  end
end
