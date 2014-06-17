class Character < ActiveRecord::Base
  belongs_to :television_show

  validates :name,
    presence: true,
    uniqueness: { scope: :television_show_id }
end
