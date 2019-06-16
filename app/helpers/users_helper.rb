module UsersHelper
  def check_action_edit
    controller.action_name == 'edit'
  end
end