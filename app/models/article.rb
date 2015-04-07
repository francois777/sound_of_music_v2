class Article < ActiveRecord::Base

  has_paper_trail on: [:update, :destroy]

  belongs_to :author, class_name: 'User'
  belongs_to :theme
  belongs_to :publishable, polymorphic: true

  enum approval_status: [:incomplete, :submitted, :to_be_revised, :approved]
  enum rejection_reason: [:not_rejected, :grammar_and_spelling, :incorrect_facts, :irrelevant_material, :not_acceptable]

  validates :title, :body, :author, :theme, presence: true
  validates :title, length: { minimum: 10, maximum: 50 }
  validate :rejected_article_requires_rejection_reason, if: :to_be_revised?
  validate :rejection_reason_only_applies_when_requesting_revision

  def not_yet_approved?
    !(approval_status == :approved)
  end

  def reason_given_for_rejection?
    return true if (self.grammar_and_spelling? || self.incorrect_facts? || self.irrelevant_material? || self.not_acceptable?)
    false
  end

  private
    def rejected_article_requires_rejection_reason
      errors.add(:approval_status, 'Must specify rejection reason when requesting a revision') if :not_rejected
    end

    def rejection_reason_only_applies_when_requesting_revision
      if not_yet_approved? and reason_given_for_rejection?
        errors.add(:rejection_reason, 'Rejection Reason only applies when requesting a revision')
      end
    end

end