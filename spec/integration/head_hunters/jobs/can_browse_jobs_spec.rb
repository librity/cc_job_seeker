# frozen_string_literal: true

require 'rails_helper'

feature 'Head Hunter can browse jobs' do
  context 'when logged-in' do
    let!(:head_hunter) { log_head_hunter_in! }

    scenario 'successfully' do
      Faker::Job.unique.clear

      job_a = create :job, head_hunter: head_hunter, position: 'Analyst'
      job_b = create :job, head_hunter: head_hunter, position: 'Janitor'

      job_c = create :job, position: 'Director', expires_on: 32.days.from_now
      job_d = create :job, position: 'Engineer', expires_on: 33.days.from_now

      visit root_path
      click_on I18n.t('activerecord.models.job.other')

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
      job_a = create :job, head_hunter: head_hunter
      job_b = create :job, head_hunter: head_hunter

      visit root_path
      click_on I18n.t('activerecord.models.job.other')
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
      head_hunter.update social_name: Faker::Name.unique.name
      job_a = create :job, head_hunter: head_hunter

      visit root_path
      click_on I18n.t('activerecord.models.job.other')
      within "tr#job-#{job_a.id}" do
        click_on I18n.t('views.navigation.details')
      end

      expect(page).to have_content job_a.head_hunter.social_name
    end

    scenario 'when no jobs were created' do
      visit root_path
      click_on I18n.t('activerecord.models.job.other')

      expect(page).to have_content I18n.t('views.jobs.empty_resource')
    end

    scenario 'and return to home page' do
      visit root_path
      click_on I18n.t('activerecord.models.job.other')
      click_on I18n.t('views.navigation.go_back')

      expect(current_path).to eq head_hunters_dashboard_path
    end

    scenario 'and return to jobs page' do
      job_a = create :job, head_hunter: head_hunter
      create :job, head_hunter: head_hunter

      visit root_path
      click_on I18n.t('activerecord.models.job.other')
      within "tr#job-#{job_a.id}" do
        click_on I18n.t('views.navigation.details')
      end
      click_on I18n.t('views.navigation.go_back')

      expect(current_path).to eq head_hunters_jobs_path
    end
  end
end
