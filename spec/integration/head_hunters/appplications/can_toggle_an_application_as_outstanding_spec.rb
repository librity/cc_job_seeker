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
      create_list :job_application, 3, job: job_a

      visit root_path
      click_on I18n.t('activerecord.models.job.other')
      within "tr#job-#{job_a.id}" do
        click_on I18n.t('views.navigation.details')
      end
      within "dd#application-#{application.id}" do
        click_on I18n.t('views.navigation.letter')
      end

      page.should have_css('.inactive_standout', count: 1)

      within '.applicant_title' do
        click_button
      end

      expect(current_path).to eq head_hunters_job_application_path(job_a, application)
      page.should have_css('.active_standout', count: 1)

      within '.applicant_title' do
        click_button
      end

      expect(current_path).to eq head_hunters_job_application_path(job_a, application)
      page.should have_css('.inactive_standout', count: 1)
    end
  end
end
