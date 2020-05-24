# frozen_string_literal: true

require 'rails_helper'

feature 'Job Seeker can browse active jobs' do
  context 'when logged-in' do
    let!(:job_seeker) { log_job_seeker_in! }

    scenario 'successfully' do
      Faker::Job.unique.clear

      job_a = create :job, position: 'Manager', expires_on: 2.month.from_now
      job_b = create :job, position: 'Director', expires_on: 5.weeks.from_now

      job_c = create :job, :expired, :skip_validate, position: 'Analyst'
      job_d = create :job, retired: true, position: 'Engineer', expires_on: 6.weeks.from_now

      visit root_path
      click_on I18n.t('views.navigation.browse_jobs')

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

    scenario 'and view details' do
      job_a = create :job
      job_b = create :job

      visit root_path
      click_on I18n.t('views.navigation.browse_jobs')
      within "tr#job-#{job_a.id}" do
        click_on I18n.t('views.navigation.details')
      end

      expect(page).to have_css('header h1', text: "#{job_a.position} de #{job_a.title}")
      expect(page).to have_content job_a.description
      expect(page).to have_content job_a.skills
      expect(page).to have_content number_to_currency(job_a.salary_floor)
      expect(page).to have_content number_to_currency(job_a.salary_roof)
      expect(page).to have_content job_a.location
      expect(page).not_to have_content I18n.t('activerecord.attributes.job.retired')
      expect(page).to have_content I18n.t('activerecord.attributes.job.active')
      expect(page).to have_content I18n.l(job_a.expires_on)
      expect(page).to have_content job_a.head_hunter.name

      expect(page).not_to have_content job_b.title
      expect(page).not_to have_content job_b.description
      expect(page).not_to have_content job_b.skills
      expect(page).not_to have_content number_to_currency(job_b.salary_floor)
      expect(page).not_to have_content number_to_currency(job_b.salary_roof)
      expect(page).not_to have_content job_b.location
      expect(page).not_to have_content I18n.l(job_b.expires_on)
    end

    scenario "and show head hunter's social name" do
      job_a = create :job
      job_a.head_hunter.update social_name: Faker::Name.unique.name

      visit root_path
      click_on I18n.t('views.navigation.browse_jobs')
      within "tr#job-#{job_a.id}" do
        click_on I18n.t('views.navigation.details')
      end

      expect(page).to have_content job_a.head_hunter.social_name
    end

    scenario 'and return to home page' do
      visit root_path
      click_on I18n.t('views.navigation.browse_jobs')
      click_on I18n.t('views.navigation.go_back')

      expect(current_path).to eq seeker_dashboard_path
    end

    scenario 'and return to jobs page' do
      job_a = create :job
      create :job

      visit root_path
      click_on I18n.t('views.navigation.browse_jobs')
      within "tr#job-#{job_a.id}" do
        click_on I18n.t('views.navigation.details')
      end
      click_on I18n.t('views.navigation.go_back')

      expect(current_path).to eq seeker_jobs_path
    end
  end
end
