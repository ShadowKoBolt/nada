module TeamMembersHelper
  def team_member_content_tag_attributes(team_member)
    if team_member.description? || team_member.contact_details?
      return :a, class: 'team-member', href: '#', data: { toggle: 'modal', target: "#team-member-#{team_member.id}" }
    else
      return :div, class: 'team-member'
    end
  end

  def offset_class(group, _size)
    group_size = group.compact.size
    return 'col-center' if group_size == 1
    return 'col-sm-offset-3' if group_size == 2
    return 'col-sm-offset-1' if group_size == 3
    ''
  end
end
