# frozen_string_literal: true

require 'rails_helper'

describe 'Logged-in Head Hunter' do
  let!(:head_hunter) { log_head_hunter_in! }

  context 'stands-out a job application' do
    it "that they don't own" do
      job_a = create :job
      applicant = create :job_seeker
      application = create :job_application, job: job_a, job_seeker: applicant

      patch head_hunters_job_application_standout_path job_a, application

      expect(response).to redirect_to(head_hunters_jobs_path)
      follow_redirect!

      expect(response.body).to include(I18n.t('flash.unauthorized'))
    end
  end
end
