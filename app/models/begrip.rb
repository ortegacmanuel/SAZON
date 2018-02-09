class Begrip < ActiveRecord::Base
  attr_reader :per_page
  @per_page = 999
  attr_writer :inline_forms_attribute_list
  has_paper_trail

  default_scope { order :name }

  def _presentation
    name + (synonym.blank? ? '' : " (#{synonym})")
  end

  validates :name, :presence => true

  def inline_forms_attribute_list
    @inline_forms_attribute_list ||= [
      [ :name , "het begrip", :text_field ],
      [ :synonym , "het begrip", :text_field ],
      [ :description , "de beschrijving", :text_area_without_ckeditor ],
    ]
  end


  def <=>(other)
    self.name <=> other.name
  end


  def self.not_accessible_through_html?
    false
  end

  def self.order_by_clause
    nil
  end


  # this is trying to fool some inline forms logic
  def deleted?
    false
  end

  def self.safe_deletable?
    true
  end

  def safe_delete(current_user)
    #not safe at all!
    self.destroy
  end

  def safe_restore
    # not even possible
  end

end
