module TeamMembersHelper
  def team_member_content_tag_attributes(team_member)
    if team_member.description? || team_member.contact_details?
      return :a, class: 'team-member', href: '#', data: { toggle: 'modal', target: "#team-member-#{team_member.id}" }
    else
      return :div, class: 'team-member'
    end
  end
end
