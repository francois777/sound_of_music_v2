class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :created_articles, class_name: 'Article', foreign_key: 'author_id' 
  has_many :approved_articles, class_name: 'Article', foreign_key: 'approver_id' 

  enum role: [:user, :approver, :owner]
  after_initialize :set_default_role, :if => :new_record?

  validates :first_name, presence: true, length: { minimum: 2, maximum: 15 }
  validates :last_name,  presence: true, length: { minimum: 2, maximum: 25 }

  scope :articles_for, -> (user) { Article.where("author_id = ?", user.id ) }

  def name
    [first_name, last_name].compact.join(' ')
  end

  def viewable_articles_for_instrument(instrument_id)
    Article.where('publishable_id = ? AND (approval_status = ? OR author_id = ?)', instrument_id, Article.approval_statuses[:approved], self.id)
  end

  private

  def set_default_role
    self.role ||= :user
  end

end
