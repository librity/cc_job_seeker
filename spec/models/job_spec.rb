# frozen_string_literal: true

require 'rails_helper'

describe Job, type: :model do
  after :each do
    Faker::Job.unique.clear
  end

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

    it 'must have at least 50 characters' do
      subject.description = 'a' * 49

      expect(subject).to_not be_valid
      expect(subject.errors[:description]).to include(I18n.t('errors.messages.too_short', count: 50))
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

    it 'must be at least one month in the future' do
      subject.expires_on = 1.month.from_now - 2.days

      expect(subject).to_not be_valid
      expect(subject.errors[:expires_on]).to include(I18n
        .t('activerecord.errors.models.job.attributes.expires_on.at_least_one_month_from_now'))
    end
  end

  context 'validation: head_hunter' do
    it 'cannot be blank' do
      subject.head_hunter = nil

      expect(subject).to_not be_valid
      expect(subject.errors[:head_hunter]).to include(I18n.t('errors.messages.blank'))
    end
  end

  context 'before save: titleize_attributes' do
    it 'should transform title, skills, position and location to title-case' do
      subject.title = 'human resources machinist'
      subject.skills = 'humbuggery, tautology, excel'
      subject.position = 'master'
      subject.location = 'paper street soap co. 123, detroit, michigan'

      subject.save!

      expect(subject.title).to eq 'Human Resources Machinist'
      expect(subject.skills).to eq 'Humbuggery, Tautology, Excel'
      expect(subject.position).to eq 'Master'
      expect(subject.location).to eq 'Paper Street Soap Co. 123, Detroit, Michigan'
    end
  end

  context 'scope: created_by' do
    it 'should filter by head_hunter' do
      target_head_hunter = create :head_hunter
      job_a = create :job, head_hunter: target_head_hunter
      job_b = create :job, head_hunter: target_head_hunter
      job_c = create :job, head_hunter: target_head_hunter
      job_d = create :job, head_hunter: target_head_hunter

      arbitrary_head_hunter = create :head_hunter
      create :job, head_hunter: arbitrary_head_hunter
      create :job, head_hunter: arbitrary_head_hunter
      create :job, head_hunter: arbitrary_head_hunter
      create :job, head_hunter: arbitrary_head_hunter

      expect(described_class.created_by(target_head_hunter))
        .to match_array [job_a, job_b, job_c, job_d]
    end
  end

  context 'method: expired?' do
    it 'should return false if expires_on is either today or in the future' do
      subject.expires_on = Date.today

      expect(subject.expired?).to be false
    end

    it 'should return true if expires_on is in the past' do
      subject = create :job, :skip_validate, :expired

      expect(subject.expired?).to be true
    end
  end

  context 'method: active?' do
    it 'should return false if retired' do
      subject.retired = true

      expect(subject.active?).to be false
    end

    it 'should return false if expired' do
      subject = create :job, :skip_validate, :expired

      expect(subject.active?).to be false
    end

    it 'should return true otherwise' do
      expect(subject.active?).to be true
    end
  end
end
