class CreatJobSeekerProfileComments < ActiveRecord::Migration[6.0]
  def change
    create_table :job_seeker_profile_comments do |t|
      t.references :job_seeker_profile, null: false, foreign_key: true
      t.references :head_hunter, null: false, foreign_key: true
      t.text :content
    end
  end
end
