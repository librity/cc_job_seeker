# frozen_string_literal: true

require 'rails_helper'

feature 'Head Hunter can browse jobs' do
  context ' when logged-in' do
    let!(:head_hunter) { log_head_hunter_in! }

    scenario 'successfully' do
      job_a = create :job, head_hunter: head_hunter
      job_b = create :job, head_hunter: head_hunter

      visit root_path
      click_on I18n.t('activerecord.models.job.other')

      expect(page).to have_content job_a.title
      expect(page).to have_content job_b.title
    end

    xscenario 'and view details' do
      honda = Manufacturer.create! name: 'Honda'

      job_one = CarCategory.create! name: 'Sedan', daily_rate: 100.0,
                                    insurance: 10.0, third_party_insurance: 5.0
      CarCategory.create! name: 'Camião', daily_rate: 140.0, insurance: 20.0,
                          third_party_insurance: 15.0

      job_one = CarModel.create! name: 'Civic', year: '2010', manufacturer: honda,
                                 metric_horsepower: '135 @ 6500 rpm', job: job_one,
                                 fuel_type: 'gasolina', metric_city_milage: 12,
                                 metric_highway_milage: 16, engine: '1.6 L R16A1 I4'
      job_two = CarModel.create! name: 'Fit', year: '2005', manufacturer: honda,
                                 metric_horsepower: '120 @ 6500 rpm', job: job_one,
                                 fuel_type: 'gasolina', metric_city_milage: 14,
                                 metric_highway_milage: 18, engine: '1.3 L L13A I4'

      visit root_path
      click_on I18n.t('activerecord.models.job.other')
      within "tr#car-category-#{job_one.id}" do
        click_on I18n.t('views.navigation.details')
      end

      expect(page).to have_css('header h1', text: "#{I18n.t 'activerecord.models.job.one'} Sedan")
      expect(page)
        .to have_content "#{I18n.t 'activerecord.attributes.job.daily_rate'}: R$ 100,00"
      expect(page)
        .to have_content "#{I18n.t 'activerecord.attributes.job.insurance'}: R$ 10,00"
      expect(page)
        .to have_content "#{I18n.t 'activerecord.attributes.job.third_party_insurance'}: R$ 5,00"

      expect(page).to have_css('dd:nth-of-type(1)', text: 'R$ 100,00')
      expect(page).to have_css('dd:nth-of-type(2)', text: 'R$ 10,00')
      expect(page).to have_css('dd:nth-of-type(3)', text: 'R$ 5,00')

      expect(page).to have_link(job_one.name, href: job_path(job_one))
      expect(page).to have_link(job_two.name, href: job_path(job_two))
      expect(page).to have_link(I18n.t('views.navigation.go_back'), href: car_categories_path)

      expect(page).not_to have_content 'Camião'
      expect(page).not_to have_content 'R$ 120,00'
      expect(page).not_to have_content 'R$ 20,00'
      expect(page).not_to have_content 'R$ 15,00'
    end

    xscenario 'when no car categories were created' do
      visit root_path
      click_on I18n.t('activerecord.models.job.other')

      expect(page).to have_content I18n.t('views.resources.car_categories.empty_resource')
    end

    xscenario 'and return to home page' do
      CarCategory.create! name: 'Sedan', daily_rate: 100.0, insurance: 10.0,
                          third_party_insurance: 5.0
      CarCategory.create! name: 'Camião', daily_rate: 140.0, insurance: 20.0,
                          third_party_insurance: 15.0

      visit root_path
      click_on I18n.t('activerecord.models.job.other')
      click_on I18n.t('views.navigation.go_back')

      expect(current_path).to eq root_path
    end

    xscenario 'and return to car categories page' do
      job_one = CarCategory.create! name: 'Sedan', daily_rate: 100.0,
                                    insurance: 10.0, third_party_insurance: 5.0
      CarCategory.create! name: 'Camião', daily_rate: 140.0, insurance: 20.0,
                          third_party_insurance: 15.0

      visit root_path
      click_on I18n.t('activerecord.models.job.other')
      within "tr#car-category-#{job_one.id}" do
        click_on I18n.t('views.navigation.details')
      end
      click_on I18n.t('views.navigation.go_back')

      expect(current_path).to eq car_categories_path
    end

    xscenario 'and view filtered car models' do
      honda = Manufacturer.create! name: 'Honda'
      fiat = Manufacturer.create! name: 'Fiat'

      sedan = CarCategory.create! name: 'Sedan', daily_rate: 100.0,
                                  insurance: 10.0, third_party_insurance: 5.0
      truck = CarCategory.create! name: 'Camião', daily_rate: 140.0, insurance: 20.0,
                                  third_party_insurance: 15.0

      civic = CarModel.create! name: 'Civic', year: '2010', manufacturer: honda,
                               metric_horsepower: '135 @ 6500 rpm', job: sedan,
                               fuel_type: 'gasolina', metric_city_milage: 12,
                               metric_highway_milage: 16, engine: '1.6 L R16A1 I4'
      uno = CarModel.create! name: 'Uno', year: '2019', manufacturer: fiat,
                             metric_horsepower: '120 @ 6500 rpm', job: sedan,
                             fuel_type: 'gasolina', metric_city_milage: 14,
                             metric_highway_milage: 18, engine: '1.3 L L13A I4'

      ridgeline = CarModel.create! name: 'Ridgeline', year: '2005', manufacturer: honda,
                                   metric_horsepower: '120 @ 6500 rpm', job: truck,
                                   fuel_type: 'gasolina', metric_city_milage: 14,
                                   metric_highway_milage: 18, engine: '1.3 L L13A I4'

      visit root_path
      click_on I18n.t('activerecord.models.job.other')
      within "tr#car-category-#{sedan.id}" do
        click_on I18n.t('views.navigation.details')
      end

      expect(page).to have_link('Honda Civic 2010', href: job_path(civic))
      expect(page).to have_link('Fiat Uno 2019', href: job_path(uno))
      expect(page).not_to have_link('Honda Ridgeline 2005', href: job_path(ridgeline))
    end
  end
end
