# frozen_string_literal: true

require 'rails_helper'

feature 'Job Seeker can browse job offers' do
  context 'when logged-in' do
    let!(:job_seeker) { log_job_seeker_in! }

    scenario "and gets redirected when accessing another's offer" do
      offer = create :job_application_offer

      visit job_seekers_offer_path offer

      expect(current_path).to eq job_seekers_offers_path
      expect(page).to have_content I18n.t 'flash.unauthorized'
    end

    scenario 'and gets redirected if the offer is accepted' do
      application = create :job_application, job_seeker: job_seeker
      offer = create :job_application_offer, :accepted, application: application

      page.driver.post job_seekers_offer_accept_path(offer)
      visit page.driver.response.location

      expect(current_path).to eq job_seekers_offer_path offer
      expect(page).to have_content I18n.t 'flash.closed_offer'
    end

    scenario 'and gets redirected if the offer is rejected' do
      application = create :job_application, job_seeker: job_seeker
      offer = create :job_application_offer, :rejected, application: application

      page.driver.post job_seekers_offer_reject_path(offer)
      visit page.driver.response.location

      expect(current_path).to eq job_seekers_offer_path offer
      expect(page).to have_content I18n.t 'flash.closed_offer'
    end
  end
end
