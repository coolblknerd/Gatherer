class Project
  attr_accessor :tasks, :due_date

  def initialize
    @tasks = []
  end

  def incomplete_tasks
    tasks.reject(&:complete?)
  end

  # Method takes each element in task array and rejects any element based on the complete block, when it returns the new array it will check if the array is empty.  If the array is empty then it will return true (done.).
  def done?
    incomplete_tasks.empty?
  end

  def total_size
    tasks.sum(&:size)
  end

  # See the comment above 'done?' for better understanding
  def remaining_size
    incomplete_tasks.sum(&:size)
  end

  def completed_velocity
    tasks.sum(&:point_toward_velocity)
  end

  def current_rate
    completed_velocity * 1.0 / Project.velocity_length_in_days
  end

  def projected_days_remaining
    remaining_size / current_rate
  end

  def on_schedule?
    return false if projected_days_remaining.nan?
    (Date.today + projected_days_remaining) <= due_date
  end

  def self.velocity_length_in_days
    21
  end

end
