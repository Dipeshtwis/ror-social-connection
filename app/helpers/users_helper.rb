module UsersHelper
  def invitation_status(invitee)
    res = ''
    return if current_user.id == invitee.id
    return if current_user.friend?(invitee)

    if current_user.pending_friends.include?(invitee)
      res << link_to('pending', '#')
    elsif current_user.friend_requests.include?(invitee)
      res << link_to('Accept', invite_path(user_id: invitee.id), method: :put)
      res << ' | '
      res << link_to('Reject', reject_path(user_id: invitee.id), method: :delete)
    else
      res << link_to('Invite', invite_path(user_id: invitee.id), method: :post)
    end

    res.html_safe
  end
end
