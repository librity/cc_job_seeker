class CreateJobApplications < ActiveRecord::Migration[6.0]
  def change
    create_table :job_applications do |t|
      t.references :job, null: false, foreign_key: true
      t.references :job_seeker, null: false, foreign_key: true
      t.text :cover_letter
    end
  end
end
