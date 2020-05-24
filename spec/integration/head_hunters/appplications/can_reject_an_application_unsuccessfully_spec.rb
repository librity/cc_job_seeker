# frozen_string_literal: true

require 'rails_helper'

feature 'Head Hunter can reject a job application' do
  context 'when logged-in' do
    let!(:head_hunter) { log_head_hunter_in! }

    scenario 'and description should be at least 50 characters long' do
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

      click_on I18n.t('views.navigation.reject')

      expect(current_path).to eq hunter_job_application_rejection_path job_a, application

      fill_in I18n.t('activerecord.attributes.job/application.rejection_feedback'), with: 'a' * 49
      click_on I18n.t('views.actions.send')

      expect(page).to have_content I18n.t('errors.messages.too_short', count: 50)
    end
  end
end
