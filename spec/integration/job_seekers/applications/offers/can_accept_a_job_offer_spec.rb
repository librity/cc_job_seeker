# frozen_string_literal: true

require 'rails_helper'

feature 'Job Seeker can browse their job offers' do
  context 'when logged-in' do
    let!(:job_seeker) { log_job_seeker_in! }

    scenario 'and accept them' do
      job_a = create :job
      application = create :job_application, job: job_a, job_seeker: job_seeker
      another_application = create :job_application, job_seeker: job_seeker
      offer = create :job_application_offer, application: application
      create_list :job_application_offer, 3, application: another_application
      create :job_application_offer, application: application

      visit seeker_applications_path
      within "tr#application-#{application.id}" do
        click_on I18n.t('views.navigation.details')
      end
      within "div#offer-#{offer.id}" do
        click_on I18n.t('views.actions.accept')
      end

      job_seeker.offers.each do |retrieved_offer|
        if retrieved_offer == offer
          expect(retrieved_offer.status).to eq 'accepted'
        else
          expect(retrieved_offer.status).to eq 'rejected'
        end
      end

      expect(current_path).to eq seeker_application_path(application)
      expect(page).to have_content I18n.t('flash.offer_accepted')
      expect(page).to have_content offer.head_hunter.resolve_name
      expect(page).to have_content I18n.l(offer.start_date)
      expect(page).to have_content I18n.l(offer.created_at, format: :long)
      expect(page).to have_content number_to_currency(offer.salary)
      expect(page).to have_content offer.responsabilities
      expect(page).to have_content offer.benefits
      expect(page).to have_content offer.expectations
      expect(page).to have_content offer.bonus
      expect(page).to have_content Job::Application::Offer.human_attribute_name('status.accepted')
      expect(page).to have_css('.accepted_offer', count: 1)
    end

    scenario 'and accept them with feedback' do
      job_a = create :job
      application = create :job_application, job: job_a, job_seeker: job_seeker
      another_application = create :job_application, job_seeker: job_seeker
      offer = create :job_application_offer, application: application
      create_list :job_application_offer, 3, application: another_application
      prototype_offer = build :job_application_offer, :with_feedback
      create :job_application_offer, application: application

      visit seeker_applications_path
      within "tr#application-#{application.id}" do
        click_on I18n.t('views.navigation.details')
      end
      within "div#offer-#{offer.id}" do
        fill_in I18n.t('views.job_seekers/offers.your_feedback'),
                with: prototype_offer.feedback
        click_on I18n.t('views.actions.accept')
      end

      job_seeker.offers.each do |retrieved_offer|
        if retrieved_offer == offer
          expect(retrieved_offer.status).to eq 'accepted'
        else
          expect(retrieved_offer.status).to eq 'rejected'
        end
      end

      expect(current_path).to eq seeker_application_path(application)
      expect(page).to have_content I18n.t('flash.offer_accepted')
      expect(page).to have_content offer.head_hunter.resolve_name
      expect(page).to have_content I18n.l(offer.start_date)
      expect(page).to have_content I18n.l(offer.created_at, format: :long)
      expect(page).to have_content number_to_currency(offer.salary)
      expect(page).to have_content offer.responsabilities
      expect(page).to have_content offer.benefits
      expect(page).to have_content offer.expectations
      expect(page).to have_content offer.bonus
      expect(page).to have_content prototype_offer.feedback
      expect(page).to have_content Job::Application::Offer.human_attribute_name('status.accepted')
      expect(page).to have_css('.accepted_offer', count: 1)
    end
  end
end
