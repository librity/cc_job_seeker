# frozen_string_literal: true

require 'rails_helper'

feature 'Job Seeker can browse job applications' do
  context 'when logged-in' do
    let!(:job_seeker) { log_job_seeker_in! }

    scenario "and gets redirected when accessing another's application" do
      application = create :job_application

      visit seeker_application_path application

      expect(current_path).to eq seeker_applications_path
      expect(page).to have_content I18n.t 'flash.unauthorized'
    end
  end
end
