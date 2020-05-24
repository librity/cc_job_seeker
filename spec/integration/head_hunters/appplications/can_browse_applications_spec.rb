# frozen_string_literal: true

require 'rails_helper'

feature 'Head Hunter can browse job applications' do
  context 'when logged-in' do
    let!(:head_hunter) { log_head_hunter_in! }

    scenario 'successfully' do
      job_a = create :job, head_hunter: head_hunter
      job_b = create :job, head_hunter: head_hunter
      job_c = create :job
      application_a = create :job_application, job: job_a
      application_b = create :job_application, job: job_b
      application_c = create :job_application, job: job_c

      visit root_path
      click_on I18n.t('views.navigation.my_applications')

      expect(current_path).to eq hunter_applications_path
      expect(page).to have_content application_a.job_seeker.resolve_name
      expect(page).to have_link job_a.title, href: hunter_job_path(job_a)
      expect(page).to have_link I18n.t('views.navigation.details'),
                                href: hunter_application_path(application_a)

      expect(page).to have_content application_b.job_seeker.resolve_name
      expect(page).to have_link job_a.title, href: hunter_job_path(job_b)
      expect(page).to have_link I18n.t('views.navigation.details'),
                                href: hunter_application_path(application_b)

      expect(page).not_to have_content application_c.job_seeker.resolve_name
      expect(page).not_to have_link job_a.title, href: hunter_job_path(job_c)
      expect(page).not_to have_link I18n.t('views.navigation.details'),
                                    href: hunter_application_path(application_c)
    end

    scenario 'and view details' do
      job = create :job, head_hunter: head_hunter
      application = create :job_application, job: job

      visit root_path
      click_on I18n.t('views.navigation.my_applications')
      within "tr#application-#{application.id}" do
        click_on I18n.t('views.navigation.details')
      end

      expect(current_path).to eq hunter_application_path application
      expect(page).to have_content application_a.job_seeker.resolve_name
      expect(page).to have_content application_a.job_seeker.profile.bio
      expect(page).to have_content application_a.cover_letter
    end

    scenario 'and return to jobs page' do
      job = create :job, head_hunter: head_hunter
      application = create :job_application, job: job

      visit root_path
      click_on I18n.t('views.navigation.my_applications')
      within "tr#application-#{application.id}" do
        click_on I18n.t('views.navigation.details')
      end
      click_on I18n.t('views.navigation.go_back')

      expect(current_path).to eq hunter_applications_path
    end

    scenario "and gets redirected when accessing another's job application" do
      job = create :job
      application = create :job_application, job: job

      visit hunter_application_path application

      expect(current_path).to eq hunter_applications_path
      expect(page).to have_content I18n.t 'flash.unauthorized'
    end
  end
end
