class CreateCachedModels < ActiveRecord::Migration[6.1]
  def change
    create_table :cached_models do |t|

      t.timestamps
    end
  end
end
