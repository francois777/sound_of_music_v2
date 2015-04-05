class Instrument < ActiveRecord::Base

  belongs_to :created_by, class_name: 'User'
  belongs_to :category
  belongs_to :subcategory

  enum approval_status: [:submitted, :approved, :to_be_revised]
  enum rejection_reason: [:not_applicable, :incorrect_facts]

  default_scope -> { order('name ASC') }

  validates :name, presence: true,
                   uniqueness: { case_sensitive: false },
                   length: { minimum: 3, maximum: 40 }

  validates :created_by_id,    presence: true
  validates :other_names,     length: { maximum: 100 }
  validates :performer_title, presence: true, 
                              length: { maximum: 40 }
  validates :origin_period,   length: { maximum: 40 }

end

