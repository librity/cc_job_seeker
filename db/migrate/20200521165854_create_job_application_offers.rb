class CreateJobApplicationOffers < ActiveRecord::Migration[6.0]
  def change
    create_table :job_application_offers do |t|
      t.references :job_application, null: false, foreign_key: true
      t.date :start_date, null: false
      t.integer :salary, null: false
      t.text :responsabilities, null: false
      t.text :benefits, null: false
      t.text :expectations
      t.text :bonus
      t.text :feedback
      t.integer :status, default: 0
    
      t.timestamps
    end
  end
end
