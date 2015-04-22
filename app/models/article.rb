class Article < ActiveRecord::Base

  has_paper_trail on: [:update, :destroy]

  belongs_to :author, class_name: 'User'
  belongs_to :theme
  belongs_to :publishable, polymorphic: true
  has_one :approval, as: :approvable, dependent: :destroy
  has_many :photos, as: :imageable

  APPROVAL_STATUSES = [:incomplete, :submitted, :to_be_revised, :approved]
  REJECTION_REASONS = [:not_rejected, :grammar_and_spelling, :incorrect_facts, :irrelevant_material, :not_acceptable]

  validates :title, :body, :author, :theme, presence: true
  validates :title, length: { minimum: 10, maximum: 50 }

  scope :all_for_publishable, -> (publishable) {
    where('articles.publishable_type = ? AND articles.publishable_id = ?', 
      publishable.class.name, publishable.id)
  }
  scope :incomplete, -> (publishable) { joins(:approval).
    where('approvals.approval_status = ? AND articles.publishable_type = ? AND articles.publishable_id = ?', 
      Approval.approval_statuses[:incomplete], publishable.class.name, publishable.id) 
  }  
  scope :submitted, -> (publishable) { joins(:approval).
    where('approvals.approval_status = ? AND articles.publishable_type = ? AND articles.publishable_id = ?', 
      Approval.approval_statuses[:submitted], publishable.class.name, publishable.id) 
  }  
  scope :approved, -> (publishable) { joins(:approval).
    where('approvals.approval_status = ? AND articles.publishable_type = ? AND articles.publishable_id = ?', 
      Approval.approval_statuses[:approved], publishable.class.name, publishable.id) 
  }  
  scope :to_be_revised, -> (publishable) { joins(:approval).
    where('approvals.approval_status = ? AND articles.publishable_type = ? AND articles.publishable_id = ?', 
      Approval.approval_statuses[:to_be_revised], publishable.class.name, publishable.id) 
  }  
  scope :own_and_other_articles, -> (publishable, user_id) { joins(:approval).
    where("(articles.author_id = ? OR approvals.approval_status = ?) AND (articles.publishable_type = ? AND articles.publishable_id = ?)", 
      user_id, Approval.approval_statuses[:approved], publishable.class.name, publishable.id)
  } 

  def approval_status_display
    approval.approval_status.humanize if approval
  end

  def rejection_reason_display
    approval.rejection_reason.humanize if approval
  end

end