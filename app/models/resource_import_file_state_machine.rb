class ResourceImportFileStateMachine
  include Statesman::Machine

  state :pending, initial: true
  state :started
  state :completed
  state :failed

  transition from: :pending, to: :started
  transition from: :started, to: [:completed, :failed]

  before_transition(from: :pending, to: :started) do |resource_import_file|
    resource_import_file.executed_at = Time.zone.now
  end

  before_transition(from: :started, to: :completed) do |resource_import_file|
    resource_import_file.error_message = nil
  end
end