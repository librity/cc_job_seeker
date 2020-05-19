class CreatJobSeekerProfileFavorites < ActiveRecord::Migration[6.0]
  def change
    create_table :job_seeker_profile_favorites do |t|
      t.references :job_seeker_profile, null: false, foreign_key: true
      t.references :head_hunter, null: false, foreign_key: true
    end
  end
end
