class Bestand < ApplicationRecord
  SLUG_FORMAT = /([[:lower:]]|[0-9]+-?[[:lower:]])(-[[:lower:]0-9]+|[[:lower:]0-9])*/
  include BaseUrlHelper
  attr_reader :per_page
  @per_page = 7
  attr_writer :inline_forms_attribute_list
  has_paper_trail

  validates :name, presence: true
  validates :slug, presence: true,
                   uniqueness: true,
                   format: { with: Regexp.new('\A' + SLUG_FORMAT.source + '\z'), message: "begint met een kleine letter en daarna kleine letters, koppelteken en cijfers" }

  mount_uploader :file, FileUploader

  def _presentation
    "#{name}<p>#{url}<p>".html_safe
  end

  def url
    build_url("files/#{slug}")
  end

  def inline_forms_attribute_list
    @inline_forms_attribute_list ||= [
      [ :name , "name", :text_field ],
      [ :slug , "slug", :text_field ],
      [ :file , "file", :file_field ],
    ]
  end


  def self.not_accessible_through_html?
    false
  end

  def self.order_by_clause
    "name"
  end


end
