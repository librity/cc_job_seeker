class CreateJobSeekerProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :job_seeker_profiles do |t|
      t.date :date_of_birth
      t.string :high_school
      t.string :college
      t.string :degrees
      t.string :courses
      t.string :interests
      t.text :description
      t.string :work_experience
      t.references :job_seeker, null: false, foreign_key: true
    end
  end
end
