class Article < ActiveRecord::Base

  has_paper_trail on: [:update, :destroy]

  belongs_to :author, class_name: 'User'
  belongs_to :publishable, polymorphic: true

  enum approval_status: [:incomplete, :submitted, :to_be_revised, :approved]
  enum rejection_reason: [:not_rejected, :grammar_and_spelling, :incorrect_facts, :irrelevant_material, :not_acceptable]

  validates :title, :body, :author, :theme, presence: true
  validates :title, length: { minimum: 10, maximum: 50 }
  validate :rejected_article_requires_rejection_reason, if: "to_be_revised?"
  validate :only_rejected_article_can_have_rejection_reason, unless: "to_be_revised?"

  private
    def rejected_article_requires_rejection_reason
      errors.add(:approval_status, :rejection_requires_reason) if rejection_reason.blank?
    end

    def only_rejected_article_can_have_rejection_reason
      errors.add(:approval_status, :rejection_only_for_review) unless (rejection_reason.nil? || rejection_reason.blank?)
    end

end