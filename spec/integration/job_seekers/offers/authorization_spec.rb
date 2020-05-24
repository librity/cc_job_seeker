# frozen_string_literal: true

require 'rails_helper'

feature 'Job Seeker can browse job offers' do
  context 'when logged-in' do
    let!(:job_seeker) { log_job_seeker_in! }

    scenario "and gets redirected when accessing another's offer" do
      offer = create :job_application_offer

      visit seeker_offer_path offer

      expect(current_path).to eq seeker_offers_path
      expect(page).to have_content I18n.t 'flash.unauthorized'
    end
  end
end
