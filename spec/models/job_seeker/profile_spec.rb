# frozen_string_literal: true

require 'rails_helper'

describe JobSeeker::Profile, type: :model do
  let(:subject) { create :job_seeker_profile }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  context 'validation: job_seeker' do
    it 'cannot be blank' do
      subject.job_seeker = nil

      expect(subject).to_not be_valid
      expect(subject.errors[:job_seeker]).to include(I18n.t('errors.messages.blank'))
    end
  end

  context 'validation: date_of_birth' do
    it 'cannot be blank' do
      subject.date_of_birth = ' '

      expect(subject).to_not be_valid
      expect(subject.errors[:date_of_birth]).to include(I18n.t('errors.messages.blank'))
    end

    it 'must be a date' do
      subject.date_of_birth = '123123'

      expect(subject).to_not be_valid
      expect(subject.errors[:date_of_birth]).to include(I18n.t('errors.messages.invalid'))
    end

    it 'must be at least 16 years in the past' do
      subject.date_of_birth = 15.years.ago

      expect(subject).to_not be_valid
      expect(subject.errors[:date_of_birth]).to include(I18n
        .t('activerecord.errors.models.job_seeker/profile.attributes.date_of_birth.at_least_sixteen_years_ago'))
    end
  end

  context 'validation: high_school' do
    it 'cannot be blank' do
      subject.high_school = ' '

      expect(subject).to_not be_valid
      expect(subject.errors[:high_school]).to include(I18n.t('errors.messages.blank'))
    end
  end

  context 'validation: interests' do
    it 'cannot be blank' do
      subject.interests = ' '

      expect(subject).to_not be_valid
      expect(subject.errors[:interests]).to include(I18n.t('errors.messages.blank'))
    end
  end

  context 'validation: description' do
    it 'cannot be blank' do
      subject.description = ' '

      expect(subject).to_not be_valid
      expect(subject.errors[:description]).to include(I18n.t('errors.messages.blank'))
    end

    it 'must have at least 50 characters' do
      subject.description = 'a' * 49

      expect(subject).to_not be_valid
      expect(subject.errors[:description]).to include(I18n.t('errors.messages.too_short', count: 50))
    end
  end

  context 'validation: avatar' do
    it 'cannot be blank' do
      subject.avatar = nil

      expect(subject).to_not be_valid
      expect(subject.errors[:avatar]).to include(I18n.t('errors.messages.blank'))
    end
  end
end
