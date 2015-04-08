class Instrument < ActiveRecord::Base
  
  belongs_to :created_by, class_name: 'User'
  belongs_to :approver,   class_name: 'User'
  belongs_to :category
  belongs_to :subcategory
  has_many :articles, as: :publishable, dependent: :destroy
  has_many :themes, dependent: :destroy
  
  before_save :assign_defaults

  enum approval_status: [:submitted, :approved, :to_be_revised]
  enum rejection_reason: [:not_rejected, :incorrect_facts]

  default_scope -> { order('name ASC') }

  validates :name, presence: true,
                   uniqueness: { case_sensitive: false },
                   length: { minimum: 3, maximum: 40 }

  validates :created_by,    presence: true
  validates :other_names,     length: { maximum: 100 }
  validates :performer_title, presence: true, 
                              length: { maximum: 40 }
  validates :origin_period,   length: { maximum: 40 }
  validate :validate_approver_required, if: "approval_status != 'submitted'"

  self.per_page = 10

  def approval_status_display
    approval_status.humanize
  end

  def rejection_reason_display
    rejection_reason.humanize
  end

  private

    def validate_approver_required
      if approver_id == nil
        errors.add(:approval_status, "An approver is required for this action")
      end
    end

    def assign_defaults
      rejection_reason = :not_rejected
      approval_status = :submitted
    end

end

