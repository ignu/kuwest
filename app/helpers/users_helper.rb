module UsersHelper
  def profile_badge_for(user)
    content_tag(:div, {:class => "profile_image" }) do
      image_tag user.the_photo(:profile), :class => "profile"
    end
  end
end
