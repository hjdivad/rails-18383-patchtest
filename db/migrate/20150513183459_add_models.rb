class AddModels < ActiveRecord::Migration
  def change
    create_table(:wars) do |t|
      t.string :name
    end

    create_table(:battles) do |t|
      t.string :name
      t.references :war
    end

    create_table(:participants) do |t|
      t.string :name
    end

    create_table(:battles_participants, id: false) do |t|
      t.references :battle
      t.references :participant
    end

    add_index :battles, :war_id
    add_index :battles_participants, [:battle_id, :participant_id], unique: true
  end
end
