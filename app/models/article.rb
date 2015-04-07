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
  validate :only_rejected_article_can_have_rejection_reason, if: :to_be_revised?
  # validate :rejection_reason_only_applies_when_requesting_revision

  private
    def rejected_article_requires_rejection_reason
      errors.add(:approval_status, 'Must specify rejection reason when requesting a revision') if :not_rejected
    end

    def only_rejected_article_can_have_rejection_reason
      errors.add(:approval_status, 'Assign rejection reason only when requesting a review') if :not_rejected
    end

    def rejection_reason_only_applies_when_requesting_revision
      puts "#{approval_status}, #{rejection_reason}"
      if [0,1,3].include? self.approval_status.to_i
        puts "checkpoint 1"
        if [1,2,3,4].include? self.rejection_reason.to_i
          puts "checkpoint 2"
          errors.add(:rejection_reason, 'Rejection Reason only applies when requesting a revision')
        end
      end
    end

end