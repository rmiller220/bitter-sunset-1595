class Project < ApplicationRecord
  validates_presence_of :name, :material
  belongs_to :challenge
  has_many :contestant_projects
  has_many :contestants, through: :contestant_projects

  def contestant_count
    contestants.size
  end

  def contestant_avg_exp
    total_exp = 0
    contestants.each do |contestant|
      total_exp += contestant.years_of_experience
    end
    if total_exp > 0
      avg_exp = total_exp/contestants.size
    else 
      return 0
    end
    avg_exp.to_f
  end

end
