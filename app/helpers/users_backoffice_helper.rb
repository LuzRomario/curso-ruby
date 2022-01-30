module UsersBackofficeHelper

    def avatar_url
        avatar = current_user.user_profile.avatar
        avatar.attached? ? avatar : "undraw_profile.svg"
    end
end
