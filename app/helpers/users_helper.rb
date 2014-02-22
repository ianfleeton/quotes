module UsersHelper

  def image_for_admin_status(user)
    if user.admin?
      ' (admin)'
    end
  end

end
