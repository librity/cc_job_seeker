# frozen_string_literal: true

require 'rails_helper'

feature 'Head Hunter can browse job applications' do
  context 'when logged-in' do
    let!(:head_hunter) { log_head_hunter_in! }

    scenario "and gets redirected when accessing another's job" do
      job_a = create :job
      applicant = create :job_seeker
      create :job_application, job: job_a, job_seeker: applicant

      visit hunter_job_path job_a

      expect(current_path).to eq hunter_jobs_path
      expect(page).to have_content I18n.t 'flash.unauthorized'
    end
  end
end
