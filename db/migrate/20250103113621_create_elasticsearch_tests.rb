class CreateElasticsearchTests < ActiveRecord::Migration[6.1]
  def change
    create_table :elasticsearch_tests do |t|
      t.string :name
      t.string :username

      t.timestamps
    end
  end
end
