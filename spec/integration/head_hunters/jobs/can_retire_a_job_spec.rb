# frozen_string_literal: true

require 'rails_helper'

feature 'Head Hunter can retire a job' do
  context 'when logged-in' do
    let!(:head_hunter) { log_head_hunter_in! }

    scenario 'successfully' do
      job = create :job, head_hunter: head_hunter

      expect(head_hunter.jobs.active.count).to eq 1

      visit root_path
      click_on I18n.t('activerecord.models.job.other')
      within "tr#job-#{job.id}" do
        click_on I18n.t('views.navigation.details')
      end
      click_on I18n.t('views.actions.retire')

      expect(current_path).to eq hunter_job_path job
      expect(head_hunter.jobs.active.count).to eq 0
      expect(page).to have_content I18n.t('flash.job_retired')
      expect(page).to have_css '.inactive_job', count: 1
    end
  end
end
