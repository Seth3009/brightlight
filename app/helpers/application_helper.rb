module ApplicationHelper
  def logo
    image_tag("logo.png", alt: "Brightlight")
  end

  def title(*parts)
    ## Don't forget to set site_name in locales/en.yml, etc.
    content_for(:title) { (parts << t(:site_name)).join(' - ') } unless parts.empty?    
  end

  # For wicked_pdf gem
  def self.asset_data_base64(path)
    asset = Rails.application.assets.find_asset(path)
    throw "Could not find asset '#{path}'" if asset.nil?
    base64 = Base64.encode64(asset.to_s).gsub(/\s+/, "")
    "data:#{asset.content_type};base64,#{Rack::Utils.escape(base64)}"
  end

  def remote_link_to_delete(model, options, &block)
    data_options = {id: model.id, message: options[:message], confirm: 'This will delete selected item. Continue?'}
    css_class = 'delete-link red-text'+options[:class]
    link_to model, data: data_options, method: :delete, remote: true, class: css_class, &block
  end

  def link_to_delete_badge(model, options, &block)
    data_options = {confirm: 'This will delete the selected badge. Continue?'}
    css_class = 'delete-badge '+options[:class]
    link_to model, data: data_options, method: :delete, remote: true, class: css_class, &block
  end

  def sort_link(column, title = nil)
    column = column.to_s
    sc = sort_column
    title ||= column.titleize
    direction = column == sc && sort_direction == "asc" ? "desc" : "asc"
    icon = sort_direction == "asc" ? "keyboard_arrow_up" : "keyboard_arrow_down"
    icon = column == sc ? icon : ""
    link_to "#{title} <i class='material-icons vmiddle'>#{icon}</i>".html_safe, 
      params.merge({column: column, direction: direction})
  end

  def number_of_unread_message
    Message.unread(current_user).count
  end

  def format_date_time(datetime)
    if datetime > Time.now.beginning_of_day && datetime < Time.now.end_of_day
      datetime.strftime("%H:%M")
    else
      datetime.strftime("%b %d") + (datetime.year != Time.now.year ? ", " + datetime.strftime : "")
    end
  end

  def currency(amount, currency: currency)
    number_to_currency(amount, unit: currency + " ", precision: currency == 'IDR' ? 0 : 2)
  end

  def impersonating?
    session[:impersonated_user_id].present?
  end 
end
