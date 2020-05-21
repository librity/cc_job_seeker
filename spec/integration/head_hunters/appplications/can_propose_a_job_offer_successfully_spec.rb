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
      job_offer = build :job_application_offer

      visit head_hunters_job_application_path job_a, application
      click_on I18n.t('views.navigation.job_offer')

      fill_in I18n.t('activerecord.attributes.job/application/offer.'),
              with: job_offer.thing
      click_on I18n.t('views.actions.send')

      expect(current_path).to eq head_hunters_job_application_path job_a, application
      expect(page).to have_content I18n.t('flash.created',
                                          resource: I18n.t('activerecord.models.job/application/offer.one'))
      expect(page).to job_offer.thing
    end
  end
end
