class Checks::ForemanTasksNotValidAnymore < ForemanMaintain::Check
  for_feature :foreman_tasks
  description 'check for invalid tasks'
  tags :basic

  def run
    assert(feature(:foreman_tasks).invalid_tasks_count == 0,
           'There are currently invalid tasks in the system')
  end

  def next_steps
    [procedure(Procedures::ForemanTasksDeleteInvalid)] if fail?
  end
end
