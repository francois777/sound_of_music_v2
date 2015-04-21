class Instrument < ActiveRecord::Base
  
  belongs_to :created_by, class_name: 'User'
  belongs_to :category
  belongs_to :subcategory
  has_one :approval, as: :approvable, dependent: :destroy
  has_many :articles, as: :publishable, dependent: :destroy
  has_many :themes, dependent: :destroy

  APPROVAL_REASONS = [:submitted, :approved, :to_be_revised]
  REJECTION_REASONS = [:not_rejected, :incorrect_facts]
  # enum approval_status: [:submitted, :approved, :to_be_revised]
  # enum rejection_reason: [:not_rejected, :incorrect_facts]

  default_scope -> { order('name ASC') }
  scope :approved, -> { joins(:approval).where('approvals.approval_status = ?', Approval.approval_statuses[:approved]) }  
  scope :submitted, -> { joins(:approval).where('approvals.approval_status = ?', Approval.approval_statuses[:submitted]) }  
  scope :own_and_other_instruments, -> (current_user_id) { 
    joins(:approval).
    where("instruments.created_by_id = ? OR approvals.approval_status = ?", current_user_id, Approval.approval_statuses[:approved])
  } 

  validates :name, presence: true,
                   uniqueness: { case_sensitive: false },
                   length: { minimum: 3, maximum: 40 }

  validates :created_by,    presence: true
  validates :other_names,     length: { maximum: 100 }
  validates :performer_title, presence: true, 
                              length: { maximum: 40 }
  validates :origin_period,   length: { maximum: 40 }

  self.per_page = 10

  def approval_status_display
    approval.approval_status.humanize
  end

  def rejection_reason_display
    approval.rejection_reason.humanize
  end


end

