# frozen_string_literal: true

module ApplicationHelper
  def same_as_current_path?(path)
    request.path_info.include? path
  end

  def flash_class(level)
    case level
    when :notice then 'alert alert-info'
    when :success then 'alert alert-success'
    when :error then 'alert alert-error'
    when :alert then 'alert alert-error'
    end
  end
end
