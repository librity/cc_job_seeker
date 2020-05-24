# frozen_string_literal: true

require 'rails_helper'

feature 'Job Seeker can browse their job offers' do
  context 'when logged-in' do
    let!(:job_seeker) { log_job_seeker_in! }

    scenario 'and reject them' do
      job_a = create :job
      application = create :job_application, job: job_a, job_seeker: job_seeker
      offer = create :job_application_offer, application: application
      create :job_application_offer, application: application

      visit root_path
      click_on I18n.t('views.navigation.my_offers')
      within "tr#offer-#{offer.id}" do
        click_on I18n.t('views.navigation.details')
      end
      click_on I18n.t('views.actions.reject')

      expect(current_path).to eq seeker_offer_path(offer)
      expect(page).to have_content I18n.t('flash.offer_rejected')
      expect(page).to have_content offer.head_hunter.resolve_name
      expect(page).to have_content I18n.l(offer.start_date)
      expect(page).to have_content I18n.l(offer.created_at, format: :long)
      expect(page).to have_content number_to_currency(offer.salary)
      expect(page).to have_content offer.responsabilities
      expect(page).to have_content offer.benefits
      expect(page).to have_content offer.expectations
      expect(page).to have_content offer.bonus
      expect(page).to have_content Job::Application::Offer.human_attribute_name('status.rejected')
      expect(page).to have_css('.rejected_offer', count: 1)
    end

    scenario 'and reject them with feedback' do
      job_a = create :job
      application = create :job_application, job: job_a, job_seeker: job_seeker
      offer = create :job_application_offer, application: application
      prototype_offer = build :job_application_offer, :with_feedback
      create :job_application_offer, application: application

      visit root_path
      click_on I18n.t('views.navigation.my_offers')
      within "tr#offer-#{offer.id}" do
        click_on I18n.t('views.navigation.details')
      end
      fill_in I18n.t('views.job_seekers/offers.your_feedback'),
              with: prototype_offer.feedback
      click_on I18n.t('views.actions.reject')

      expect(current_path).to eq seeker_offer_path(offer)
      expect(page).to have_content I18n.t('flash.offer_rejected')
      expect(page).to have_content offer.head_hunter.resolve_name
      expect(page).to have_content I18n.l(offer.start_date)
      expect(page).to have_content I18n.l(offer.created_at, format: :long)
      expect(page).to have_content number_to_currency(offer.salary)
      expect(page).to have_content offer.responsabilities
      expect(page).to have_content offer.benefits
      expect(page).to have_content offer.expectations
      expect(page).to have_content offer.bonus
      expect(page).to have_content prototype_offer.feedback
      expect(page).to have_content Job::Application::Offer.human_attribute_name('status.rejected')
      expect(page).to have_css('.rejected_offer', count: 1)
    end
  end
end
