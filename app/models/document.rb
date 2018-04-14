class Document < ActiveRecord::Base
  attr_reader :per_page
  @per_page = 999
  attr_writer :inline_forms_attribute_list
  has_paper_trail

  belongs_to :document

  has_many :documents
  has_many :assignments
  has_many :images

  validates :name, presence: true
  validates :slug, presence: true, format: { with: Rails.configuration.slug_regex, message: "begint met een kleine letter en daarna kleine letters, underscore en cijfers" }

  default_scope { order :name }

  def _presentation
    name
  end

  def nice_number
    self.name.scan(/[.0-9]+/).first.gsub('0','')
  end

  def nice_title
    nice_number.length > 1 ? "#{nice_number} #{title}" : title
  end

  def clean_name
    slug
  end

  def parent
    self.document
  end

  def has_no_parent?
    self.parent.nil?
  end

  def children
    documents.where(which_menu: [1, 3]).each.map do |document|
      [document, document.children]
    end
  end

  def url
    if Rails.env.production?
      "https://sazon.id-arte.net/view/#{slug}"
    else
      "http://127.0.0.1:3001/view/#{slug}"
    end
  end

  def root_and_children
    [Document.find(ROOT_ID), Document.find(ROOT_ID).children].flatten
  end

  def next
    root_and_children[root_and_children.index(self)+1] rescue nil
  end

  def previous
    position = (root_and_children.index(self) - 1) rescue -1
    position < 0 ? nil : root_and_children[position]
  end


  def is_root?
    self.id == ROOT_ID
  end

  def is_module?
    self.id == self.this_module.id
  end

  def this_module
    return Document.find(ROOT_ID) if self.is_root? || self.has_no_parent?
    parent.is_root? ? self : parent.this_module
  end

  def this_chapter
    return Document.find(ROOT_ID) if self.is_module? || self.is_root? || self.has_no_parent?
    parent.is_module? ? self : parent.this_chapter
  end

  def begrips
    begrips = []
    content = self.content + images.all.map {|i| i.description }.join
    content.gsub!(/\/uploads\/ckeditor\/pictures\/([0-9]+)\/content_/,'/uploads/ckeditor/pictures/\1/content-')
    text_begrips = content.downcase.scan(/_.+?_/).map {|x|Nokogiri::HTML.parse(x.gsub('_','')).text}

    begrips << Begrip.where(name: text_begrips)
    begrips << Begrip.joins(:related_words).where(related_words: { name: text_begrips } )
    begrips.flatten.uniq.sort
  end

  def inline_forms_attribute_list
    @inline_forms_attribute_list ||= [
      [ :name , "name", :text_field ],
      [ :slug , "name", :text_field ],
      [ :document , "name", :dropdown ],
      [ :which_menu, '', :dropdown_with_values, WHICH_MENU],
      [ :css , "content", :text_area_without_ckeditor ],
      [ :header_content, '', :header ],
      [ :title , "title", :text_field ],
      [ :content , "content", :text_area ],
      [ :sidebar, '', :text_area ],
      [ :assignments, '', :associated ],
      [ :documents, '', :associated ],
      [ :header_masonry, '', :header ],
      [ :masonry_title_above, '', :dropdown_with_values, JA_NEE ],
      [ :masonry_text_above, '', :dropdown_with_values, JA_NEE ],
      [ :masonry_column_width, '', :text_field ],
      [ :masonry_gutter_width, '', :text_field ],
      [ :images, '', :associated ],
    ]
  end


  def <=>(other)
    self.last_name <=> other.last_name
  end


  def self.not_accessible_through_html?
    false
  end

  def self.order_by_clause
    nil
  end


end
