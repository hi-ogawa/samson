# frozen_string_literal: true
# expects command_associations to be defined in base class
# TODO: inline this into stage.rb and move tests over
module HasCommands
  def self.included(base)
    base.class_eval do
      before_save :build_new_project_command
      attr_writer :command
    end
  end

  def script(previous: false)
    method = (previous ? :command_was : :command)
    commands.map(&method).join("\n")
  end

  def command_ids=(new_command_ids)
    super.tap do
      reorder_commands(new_command_ids.reject(&:blank?).map(&:to_i))
    end
  end

  private

  def build_new_project_command
    return unless @command.present?

    new_command = project.commands.build(command: @command)
    command_associations.build(command: new_command).tap do
      reorder_commands
    end
  end

  def reorder_commands(command_ids = self.command_ids)
    command_associations.each do |command_association|
      command_association.position = command_ids.index(command_association.command_id) ||
        command_associations.length
    end
  end
end
