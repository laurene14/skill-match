module ApplicationHelper
  def touch_action_style
    request.path == '/likes' ? 'touch-action: none;' : ''
  end
end
