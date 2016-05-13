class Task < ActiveRecord::Base

  belongs_to :project

  def complete?
    completed_at.present?
  end

  # sets
  def mark_completed(date = nil)
    self.completed_at = (date || Time.current)
  end

  def part_of_velocity?
    return false unless complete? # False unless complete is true
    completed_at > Project.velocity_length_in_days.days.ago # If complete? is beyond 3 weeks ago
  end

  # if part_of_velocity is true return the size if not return 0
  def point_toward_velocity
    if part_of_velocity? then size else 0 end
  end

end
