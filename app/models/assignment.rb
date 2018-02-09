class Assignment < ActiveRecord::Base
  attr_reader :per_page
  @per_page = 7
  attr_writer :inline_forms_attribute_list
  has_paper_trail

  belongs_to :document

  validates :name, presence: true

  default_scope { order :name }

  def _presentation
    name
  end


  def inline_forms_attribute_list
    @inline_forms_attribute_list ||= [
      [ :name , "name", :text_field ],
      [ :title , "title", :text_field ],
      [ :content , "content", :text_area ],
      [ :document , "content", :dropdown ],
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
