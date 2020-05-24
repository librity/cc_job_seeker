# frozen_string_literal: true

require 'rails_helper'

feature 'Job Seeker can browse their job offers' do
  context 'when logged-in' do
    let!(:job_seeker) { log_job_seeker_in! }

    scenario 'successfully' do
      job_a = create :job
      application = create :job_application, job: job_a, job_seeker: job_seeker
      offer_a = create :job_application_offer, application: application
      offer_b = create :job_application_offer, application: application

      offer_c = create :job_application_offer

      visit root_path
      click_on I18n.t('views.navigation.my_offers')

      expect(current_path).to eq seeker_offers_path
      expect(page).to have_content job_a.title, count: 2
      expect(page).to have_content offer_a.head_hunter.resolve_name
      expect(page).to have_content I18n.l(offer_a.start_date)
      expect(page).to have_content number_to_currency(offer_a.salary)

      expect(page).to have_content offer_b.head_hunter.resolve_name
      expect(page).to have_content I18n.l(offer_b.start_date)
      expect(page).to have_content number_to_currency(offer_b.salary)

      expect(page).not_to have_content offer_c.application.job.title
      expect(page).not_to have_content offer_c.head_hunter.resolve_name
      expect(page).not_to have_content I18n.l(offer_c.start_date)
      expect(page).not_to have_content number_to_currency(offer_c.salary)
    end

    scenario 'and view details' do
      job_a = create :job
      application = create :job_application, job: job_a, job_seeker: job_seeker
      offer = create :job_application_offer, application: application
      create :job_application_offer, application: application

      visit root_path
      click_on I18n.t('views.navigation.my_offers')
      within "tr#offer-#{offer.id}" do
        click_on I18n.t('views.navigation.details')
      end

      expect(current_path).to eq seeker_offer_path(offer)
      expect(page).to have_content offer.head_hunter.resolve_name
      expect(page).to have_content I18n.l(offer.start_date)
      expect(page).to have_content I18n.l(offer.created_at, format: :long)
      expect(page).to have_content number_to_currency(offer.salary)
      expect(page).to have_content offer.responsabilities
      expect(page).to have_content offer.benefits
      expect(page).to have_content offer.expectations
      expect(page).to have_content offer.bonus
      expect(page).to have_content Job::Application::Offer.human_attribute_name("status.#{offer.status}")
      expect(page).to have_css('.ongoing_offer', count: 1)
    end
  end
end
