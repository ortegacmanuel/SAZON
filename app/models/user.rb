class User < ActiveRecord::Base

  # devise options
  devise :database_authenticatable
  # devise :registerable # uncomment this if you want people to be able to register
  # devise :recoverable
  devise :rememberable
  devise :trackable
  devise :validatable
  # devise :token_authenticatable
  # devise :confirmable,
  # devise :lockable
  # devise :timeoutable
  # devise :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_writer :inline_forms_attribute_list
  #attr_accessible :email, :password, :locale, :remember_me

  belongs_to :locale
  has_and_belongs_to_many :roles

  # validations
  validates :name, :presence => true

  default_scope {order :name}

  # pagination
  attr_reader :per_page
  @per_page = 7

  has_paper_trail

  def _presentation
    "#{name}"
  end

  def role?(role)
    return !!self.roles.find_by_name(role)
  end

  def inline_forms_attribute_list
    @inline_forms_attribute_list ||= [
      [ :header_user_login,         '', :header ],
      [ :name,                      '', :text_field ],
      [ :email,                     '', :text_field ],
      [ :locale ,                   '', :dropdown ],
      [ :password,                  '', :devise_password_field ],
      [ :header_user_roles,         '', :header ],
      [ :roles,                     '', :check_list ],
      [ :header_user_other_stuff,   '', :header ],
      [ :encrypted_password,        '', :info ],
      [ :reset_password_token,      '', :info ],
      [ :reset_password_sent_at,    '', :info],
      [ :remember_created_at,       '', :info ],
      [ :sign_in_count,             '', :info ],
      [ :current_sign_in_at,        '', :info ],
      [ :last_sign_in_at,           '', :info ],
      [ :current_sign_in_ip,        '', :info ],
      [ :last_sign_in_ip,           '', :info ],
      [ :created_at,                '', :info ],
      [ :updated_at,                '', :info ],
    ]
  end

  def self.not_accessible_through_html?
    false
  end

  def self.order_by_clause
    nil
  end

end
