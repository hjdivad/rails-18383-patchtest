class War < ActiveRecord::Base
  has_many :battles

  def self.m2mtest
    wars = 
      all.
        limit(50).
        includes(battles: :participants).
        order(name: :asc)

    # load_participants! wars
  end

  def self.load_participants!(wars)

    battle_ids = wars.reduce([]) do |ids, trip|
      ids += trip.battles.map(&:id)
    end

    pw = Arel::Table.new(:battles_participants)
    conn = ActiveRecord::Base.connection
    battle_id_pass_ids = Hash.new{|h, k| h[k] = []}
    conn.exec_query(pw.project(pw[:battle_id], pw[:participant_id]).where(pw[:battle_id].in(battle_ids)).to_sql).each do |row|
      battle_id_pass_ids.tap do |h|
        h[row["battle_id"].to_i] << row["participant_id"].to_i
      end
    end

    participant_ids = battle_id_pass_ids.values.flatten
    participant_ids_participant = Participant.where(id: participant_ids).reduce({}) do |hash, participant|
      hash.tap do |h|
        h[participant.id] = participant
      end
    end

    wars.map(&:battles).flatten.compact.each do |battle|
      pass_ids = battle_id_pass_ids[battle.id]
      participants = pass_ids.map{|id| participant_ids_participant[id]}.compact

      association = battle.association(:participants)
      association.loaded!
      association.target.clear
      association.target.concat(participants)
    end

    wars
  end
end
