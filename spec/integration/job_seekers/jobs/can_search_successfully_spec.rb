# frozen_string_literal: true

require 'rails_helper'

feature 'Job Seeker can search active jobs ' do
  context 'when logged-in' do
    let!(:job_seeker) { log_job_seeker_in! }

    scenario 'by the contents of title or description successfully' do
      Faker::Job.unique.clear

      job_a = create :job, title: 'She is a heartbreaker, undertaker, moneymaker'
      job_b = create :job, description: 'The Undertaker drew a heavy sigh seeing no one else had come.'

      job_c = create :job, title: 'Manager'
      job_d = create :job, title: 'Director'

      visit root_path
      click_on I18n.t('activerecord.models.job.other')

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
              with: 'undertaker'
      click_on I18n.t('views.actions.search')

      expect(current_path).to eq job_seekers_jobs_path
      expect(page).to have_content job_a.position
      expect(page).to have_content job_a.title
      expect(page).to have_content I18n.l(job_a.expires_on)
      expect(page).to have_content job_b.position
      expect(page).to have_content job_b.title
      expect(page).to have_content I18n.l(job_b.expires_on)

      expect(page).not_to have_content job_c.position
      expect(page).not_to have_content job_c.title
      expect(page).not_to have_content I18n.l(job_c.expires_on)
      expect(page).not_to have_content job_d.position
      expect(page).not_to have_content job_d.title
      expect(page).not_to have_content I18n.l(job_d.expires_on)

      fill_in I18n.t('views.jobs.search'),
              with: 'dertak'
      click_on I18n.t('views.actions.search')

      expect(current_path).to eq job_seekers_jobs_path
      expect(page).to have_content job_a.position
      expect(page).to have_content job_a.title
      expect(page).to have_content I18n.l(job_a.expires_on)
      expect(page).to have_content job_b.position
      expect(page).to have_content job_b.title
      expect(page).to have_content I18n.l(job_b.expires_on)

      expect(page).not_to have_content job_c.position
      expect(page).not_to have_content job_c.title
      expect(page).not_to have_content I18n.l(job_c.expires_on)
      expect(page).not_to have_content job_d.position
      expect(page).not_to have_content job_d.title
      expect(page).not_to have_content I18n.l(job_d.expires_on)

      fill_in I18n.t('views.jobs.search'),
              with: 'Undertaker'
      click_on I18n.t('views.actions.search')

      expect(current_path).to eq job_seekers_jobs_path
      expect(page).to have_content job_a.position
      expect(page).to have_content job_a.title
      expect(page).to have_content I18n.l(job_a.expires_on)
      expect(page).to have_content job_b.position
      expect(page).to have_content job_b.title
      expect(page).to have_content I18n.l(job_b.expires_on)

      expect(page).not_to have_content job_c.position
      expect(page).not_to have_content job_c.title
      expect(page).not_to have_content I18n.l(job_c.expires_on)
      expect(page).not_to have_content job_d.position
      expect(page).not_to have_content job_d.title
      expect(page).not_to have_content I18n.l(job_d.expires_on)
    end
  end
end
