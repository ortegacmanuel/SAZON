class Begrip < ActiveRecord::Base
  attr_reader :per_page
  @per_page = 999
  attr_writer :inline_forms_attribute_list
  has_paper_trail

  has_many :related_words

  default_scope { order :name }

  scope :exclude_isms, -> { where(is_ism: 0) }
  scope :only_isms, -> { where(is_ism: 1) }

  def _presentation
    name + related_words_text('(', ')')
  end

  def related_words_text(start_text='', end_text='')
    return '' if related_words.empty?
    "#{start_text}#{related_words.map(&:name).join(', ')}#{end_text}"
  end

  validates :name, :presence => true

  def inline_forms_attribute_list
    @inline_forms_attribute_list ||= [
      [ :name , "het begrip", :text_field ],
      [ :description , "de beschrijving", :text_area_without_ckeditor ],
      [ :is_ism, 'is_ism', :radio_button, { 0 => 'no', 1 => 'yes' } ],
      [ :related_words , "het begrip", :associated ],
    ]
  end

  def self.find_by_name(name)
     find_by(name: name) || find_by_related_word(name)
  end

  def self.find_by_related_word(word)
    Begrip.joins(:related_words).where("related_words.name = '#{word}'").first
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
