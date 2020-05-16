# frozen_string_literal: true

require 'rails_helper'

describe Job, type: :model do
  let(:subject) { create :job }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  context 'validation: title' do
    it 'cannot be blank' do
      subject.title = ' '

      expect(subject).to_not be_valid
      expect(subject.errors[:title]).to include(I18n.t('errors.messages.blank'))
    end
  end

  context 'validation: description' do
    it 'cannot be blank' do
      subject.description = ' '

      expect(subject).to_not be_valid
      expect(subject.errors[:description]).to include(I18n.t('errors.messages.blank'))
    end
  end

  context 'validation: skills' do
    it 'cannot be blank' do
      subject.skills = ' '

      expect(subject).to_not be_valid
      expect(subject.errors[:skills]).to include(I18n.t('errors.messages.blank'))
    end
  end

  context 'validation: salary_floor' do
    it 'cannot be blank' do
      subject.salary_floor = ' '

      expect(subject).to_not be_valid
      expect(subject.errors[:salary_floor]).to include(I18n.t('errors.messages.blank'))
    end

    it 'should be numerical' do
      subject.salary_floor = '12B4'

      expect(subject).to_not be_valid
      expect(subject.errors[:salary_floor])
        .to include(I18n.t('errors.messages.not_a_number'))
    end

    it 'should be an integer' do
      subject.salary_floor = '12.4'

      expect(subject).to_not be_valid
      expect(subject.errors[:salary_floor])
        .to include(I18n.t('errors.messages.not_an_integer'))
    end

    it 'should be greater than or equal to brazilian minimum wage' do
      subject.salary_floor = '1038'

      expect(subject).to_not be_valid
      expect(subject.errors[:salary_floor])
        .to include(I18n.t('errors.messages.greater_than_or_equal_to', count: 1039))
    end

    it 'should be less than than 50,000.00' do
      subject.salary_floor = '50000'

      expect(subject).to_not be_valid
      expect(subject.errors[:salary_floor])
        .to include(I18n.t('errors.messages.less_than', count: 50_000))
    end
  end

  context 'validation: salary_roof' do
    it 'cannot be blank' do
      subject.salary_roof = ' '

      expect(subject).to_not be_valid
      expect(subject.errors[:salary_roof]).to include(I18n.t('errors.messages.blank'))
    end

    it 'should be numerical' do
      subject.salary_roof = '12B4'

      expect(subject).to_not be_valid
      expect(subject.errors[:salary_roof])
        .to include(I18n.t('errors.messages.not_a_number'))
    end

    it 'should be an integer' do
      subject.salary_roof = '12.4'

      expect(subject).to_not be_valid
      expect(subject.errors[:salary_roof])
        .to include(I18n.t('errors.messages.not_an_integer'))
    end

    it 'should be greater than salary_floor by at least 200.00' do
      subject.salary_roof = subject.salary_floor

      expect(subject).to_not be_valid
      expect(subject.errors[:salary_roof])
        .to include(I18n.t('errors.messages.greater_than_or_equal_to', count: subject.salary_roof + 200))
    end

    it 'should be less than than 50,200.00' do
      subject.salary_roof = '50200'

      expect(subject).to_not be_valid
      expect(subject.errors[:salary_roof])
        .to include(I18n.t('errors.messages.less_than', count: 50_200))
    end
  end

  context 'validation: position' do
    it 'cannot be blank' do
      subject.position = ' '

      expect(subject).to_not be_valid
      expect(subject.errors[:position]).to include(I18n.t('errors.messages.blank'))
    end
  end

  context 'validation: location' do
    it 'cannot be blank' do
      subject.location = ' '

      expect(subject).to_not be_valid
      expect(subject.errors[:location]).to include(I18n.t('errors.messages.blank'))
    end
  end

  context 'validation: retired' do
    it 'should be false by default' do
      expect(subject.retired).to be false
    end
  end

  context 'validation: expires_on' do
    it 'cannot be blank' do
      subject.expires_on = ' '

      expect(subject).to_not be_valid
      expect(subject.errors[:expires_on]).to include(I18n.t('errors.messages.blank'))
    end

    it 'must be a date' do
      subject.expires_on = '123123'

      expect(subject).to_not be_valid
      expect(subject.errors[:expires_on]).to include(I18n.t('errors.messages.invalid'))
    end

    it 'must be in the future' do
      subject.expires_on = Date.yesterday - 2.days

      expect(subject).to_not be_valid
      expect(subject.errors[:expires_on]).to include(I18n
        .t('activerecord.errors.models.job.attributes.expires_on.cant_be_retroactive'))
    end
  end

  context 'validation: head_hunter' do
    it 'cannot be blank' do
      subject.head_hunter = nil

      expect(subject).to_not be_valid
      expect(subject.errors[:head_hunter]).to include(I18n.t('errors.messages.blank'))
    end
  end
end
