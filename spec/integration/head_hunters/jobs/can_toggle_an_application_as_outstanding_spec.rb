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

      page.should have_css('.small_inactive_standout', count: 4)

      within "dd#application-#{application.id}" do
        click_button
      end

      expect(current_path).to eq head_hunters_job_path(job_a)
      page.should have_css('.small_active_standout', count: 1)
      page.should have_css('.small_inactive_standout', count: 3)

      within "dd#application-#{application.id}" do
        click_button
      end

      expect(current_path).to eq head_hunters_job_path(job_a)
      page.should have_css('.small_inactive_standout', count: 4)
    end
  end
end
