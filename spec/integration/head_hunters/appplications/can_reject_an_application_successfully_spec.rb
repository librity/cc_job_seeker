# frozen_string_literal: true

require 'rails_helper'

feature 'Head Hunter can reject a job application' do
  context 'when logged-in' do
    let!(:head_hunter) { log_head_hunter_in! }

    scenario 'successfully' do
      job_a = create :job, head_hunter: head_hunter
      applicant = create :job_seeker
      create :job_seeker_profile, job_seeker: applicant
      application = create :job_application, job: job_a, job_seeker: applicant
      rejected_application = build :job_application, :rejected

      visit root_path
      click_on I18n.t('activerecord.models.job.other')
      within "tr#job-#{job_a.id}" do
        click_on I18n.t('views.navigation.details')
      end
      within "dd#application-#{application.id}" do
        click_on I18n.t('views.navigation.letter')
      end

      click_on I18n.t('views.navigation.reject')

      expect(current_path).to eq hunter_application_rejection_path(application)

      fill_in I18n.t('activerecord.attributes.job/application.rejection_feedback'),
              with: rejected_application.rejection_feedback
      click_on I18n.t('views.actions.send')

      expect(current_path).to eq hunter_applications_path
      expect(page).to have_content I18n.t 'flash.application_rejected'
      expect(page).not_to have_link applicant.resolve_name,
                                    href: hunter_applicant_path(applicant)
      expect(page).not_to have_link I18n.t('views.navigation.letter'),
                                    href: hunter_application_path(application)
    end
  end
end
