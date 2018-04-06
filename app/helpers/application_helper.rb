module ApplicationHelper
  def application_name
    'SAZON'
  end
  def application_title
    'SAZON'
  end

  def add_tooltips content = '', format = 'html', lightbox = false
    content = content.gsub(/\/uploads\/ckeditor\/pictures\/([0-9]+)\/content_/,'/uploads/ckeditor/pictures/\1/content-')
    content_begrips = content.scan(/_.+?_/).sort
    content_begrips.each do |needle|
      clean_needle = needle.gsub('_','')
      begrip = Begrip.find_by(name: Nokogiri::HTML.parse(clean_needle).text)
      if begrip.nil?
        content = content.gsub(needle, clean_needle)
      else
        if format == 'html'
          description = "#{begrip.description.gsub('"', "&quot;")}" + (begrip.synonym.blank? ? '' : "<br /><br />Synoniemen: #{begrip.synonym}")
          content = content.gsub(needle, "<span data-tooltip data-options=\"hover_delay: 10;\" aria-haspopup=\"true\" class=\"has-tip radius\" title=\"#{description}\">#{clean_needle}</span>")
        elsif format == 'pdf'
          content = content.gsub(needle, "<span class='pdf_begrip'>#{clean_needle}</span>")
        end
      end
    end
    if lightbox
      content += "<script>
        $(document).foundation('tooltip', 'reflow');
        $('.tooltip').css('z-index', '99999');
        </script>"
    end
    content.gsub(/\/uploads\/ckeditor\/pictures\/([0-9]+)\/content-/,'/uploads/ckeditor/pictures/\1/content_')
  end
end
