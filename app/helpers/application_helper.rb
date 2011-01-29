module ApplicationHelper
  def title(page_title)
    content_for(:title) { page_title }
  end

  def nav_links(links)
    content_for(:nav_links) { links }
  end

  def subnav_links(links)
    content_for(:subnav_links) { links }
  end
end
