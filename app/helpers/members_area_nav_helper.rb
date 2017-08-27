module MembersAreaNavHelper
  def link_to_for_members_area_nav(text, link, options={})
    options = options.merge(class: css_class(link))
    link_to text, link, options
  end

  private

  def css_class(link)
    return 'tab-nav--link__active' if link == members_area_path && controller_name == 'members_area'
    'tab-nav--link'
  end
end
