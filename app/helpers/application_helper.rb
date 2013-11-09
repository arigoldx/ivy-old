# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def title(page_title)
    content_for(:title) { page_title }
  end

  def pagination_links_remote(paginator)
    page_options = {:window_size => 1}
    pagination_links_each(paginator, page_options) do |n|
      options = {
        :url => { :params => params.merge({:page => n}) },
        :method => 'get',
        :update => 'table',
        :before => "Element.show('spinner')",
        :success => "Element.hide('spinner')"
      }
      html_options = {:href => url_for(:params => params.merge({:page => n}))}
      link_to_remote(n.to_s, options, html_options)
    end
  end

  def link_to_sorter(text, field)
      key = field
      key += "_reverse" if params[:sort] == key

      options = {
          :url => {:params => params.merge({:sort => key})},
          :method => 'get',
          :update => 'table',
          :before => "Element.show('spinner')",
          :success => "Element.hide('spinner')"
      }
      html_options = {
          :title => "sort by this field",
          :href => url_for(:params => params.merge({:sort => key}))
      }
      link_to_remote(text, options, html_options)
  end

  def spinner
      image_tag("spinner.gif", :align => "absmiddle", :border => 0, :id => "spinner",  :style =>"display: none;" )
  end

  def grading_types_for_select
      [["no grading type", "0"], ["complete/incomplete", "1"], ["min/max", "2"]]
  end

  def days_of_week_options_for_select
      options_for_select([["monday" ,"1"],["tuesday", "2"],["wednesday" , "3"],["thursday", "4"],["friday", "5"]])
  end
end
