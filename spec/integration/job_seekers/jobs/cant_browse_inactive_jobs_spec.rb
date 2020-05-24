# frozen_string_literal: true

require 'rails_helper'

feature 'Job Seeker can browse jobs' do
  context 'when logged-in' do
    let!(:job_seeker) { log_job_seeker_in! }

    scenario "and there aren't any active jobs" do
      create :job, :expired, :skip_validate
      create :job, :retired

      visit root_path
      click_on I18n.t('views.navigation.browse_jobs')

      expect(page).to have_content I18n.t('views.jobs.empty_resource')
    end

    scenario "and gets redirected when job isn't active" do
      job_a = create :job, :expired, :skip_validate
      job_b = create :job, :retired

      visit job_seekers_job_path job_a

      expect(page).to have_content I18n.t('flash.inactive_job')
      expect(current_path).to eq job_seekers_jobs_path

      visit job_seekers_job_path job_b

      expect(page).to have_content I18n.t('flash.inactive_job')
      expect(current_path).to eq job_seekers_jobs_path
    end
  end
end
