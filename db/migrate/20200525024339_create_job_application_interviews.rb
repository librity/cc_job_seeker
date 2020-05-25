class CreateJobApplicationInterviews < ActiveRecord::Migration[6.0]
  def change
    create_table :job_application_interviews do |t|
      t.references :head_hunter, null: false, foreign_key: true
      t.references :job_application, null: false, foreign_key: true
      t.string :address
      t.datetime :date
      t.boolean :public_feedback, default: false
      t.text :feedback
      t.boolean :occurred, default: nil

      t.timestamps
    end
  end
end
