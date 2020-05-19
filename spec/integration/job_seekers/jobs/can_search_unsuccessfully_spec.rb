# frozen_string_literal: true

require 'rails_helper'

feature 'Job Seeker can search active jobs ' do
  context 'when logged-in' do
    let!(:job_seeker) { log_job_seeker_in! }

    scenario "and renders a flash message when it doesn't find any" do
      Faker::Job.unique.clear

      job_a = create :job
      job_b = create :job
      job_c = create :job
      job_d = create :job

      visit root_path
      click_on I18n.t('activerecord.models.job.other')

      fill_in I18n.t('views.jobs.search'),
              with: Faker::Books::Lovecraft.location
      click_on I18n.t('views.actions.search')

      expect(current_path).to eq job_seekers_jobs_path
      expect(page).to have_content I18n.t('flash.job_not_found')

      expect(page).to have_content job_a.position
      expect(page).to have_content job_a.title
      expect(page).to have_content I18n.l(job_a.expires_on)
      expect(page).to have_content job_b.position
      expect(page).to have_content job_b.title
      expect(page).to have_content I18n.l(job_b.expires_on)

      expect(page).to have_content job_c.position
      expect(page).to have_content job_c.title
      expect(page).to have_content I18n.l(job_c.expires_on)
      expect(page).to have_content job_d.position
      expect(page).to have_content job_d.title
      expect(page).to have_content I18n.l(job_d.expires_on)

      fill_in I18n.t('views.jobs.search'),
              with: Faker::Books::Lovecraft.location
      click_on I18n.t('views.actions.search')

      expect(current_path).to eq job_seekers_jobs_path
      expect(page).to have_content I18n.t('flash.job_not_found')

      expect(page).to have_content job_a.position
      expect(page).to have_content job_a.title
      expect(page).to have_content I18n.l(job_a.expires_on)
      expect(page).to have_content job_b.position
      expect(page).to have_content job_b.title
      expect(page).to have_content I18n.l(job_b.expires_on)

      expect(page).to have_content job_c.position
      expect(page).to have_content job_c.title
      expect(page).to have_content I18n.l(job_c.expires_on)
      expect(page).to have_content job_d.position
      expect(page).to have_content job_d.title
      expect(page).to have_content I18n.l(job_d.expires_on)
    end
  end
end
