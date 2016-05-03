class Task
  attr_accessor :size, :completed_at

  def initialize(options = {})
    mark_completed(options[:completed_at]) if options[:completed_at]
    @size = options[:size]
  end

  def complete?
    @completed_at.present?
  end

  # sets
  def mark_completed(date = nil)
    @completed_at = (date || Time.current)
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
