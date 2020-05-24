# frozen_string_literal: true

require 'rails_helper'

feature 'Head Hunter can browse job applications' do
  context 'when logged-in' do
    let!(:head_hunter) { log_head_hunter_in! }

    scenario 'successfully' do
      job = create :job, head_hunter: head_hunter
      applications = create_list :job_application, 3, job: job
      offers = applications.map do |application|
        create :job_application_offer, head_hunter: head_hunter, application: application
      end

      visit root_path
      click_on I18n.t('views.navigation.my_offers')

      expect(current_path).to eq hunter_offers_path
      offers.each do |offer|
        expect(page).to have_content offer.job_seeker.resolve_name
        expect(page).to have_content offer.job.title
        expect(page).to have_content I18n.l(offer.start_date)
        expect(page).to have_content number_to_currency(offer.salary)
        expect(page).to have_content Job::Application::Offer.human_attribute_name("status.#{offer.status}")
        expect(page).to have_link I18n.t('views.navigation.details'),
                                  href: hunter_offer_path(offer)
      end
    end

    scenario 'and view offer details' do
      job = create :job, head_hunter: head_hunter
      application = create :job_application, job: job
      create :job_seeker_profile, job_seeker: application.job_seeker
      offer = create :job_application_offer, head_hunter: head_hunter,
                                             application: application

      visit root_path
      click_on I18n.t('views.navigation.my_offers')
      within "tr#offer-#{offer.id}" do
        click_on I18n.t('views.navigation.details')
      end

      expect(current_path).to eq hunter_offer_path(offer)
      expect(page).to have_content offer.job_seeker.resolve_name
      expect(page).to have_content I18n.l(offer.created_at, format: :long)
      expect(page).to have_content I18n.l(offer.start_date)
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
