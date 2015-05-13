class Battle < ActiveRecord::Base
  belongs_to :war
  has_and_belongs_to_many :participants, -> { where('2>1') }
end
