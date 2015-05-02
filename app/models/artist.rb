class Artist < ActiveRecord::Base
  attr_accessor :name_profile

  belongs_to :submitted_by, class_name: 'User'
  belongs_to :historical_period
  has_one :approval, as: :approvable, dependent: :destroy
  has_many :articles, as: :publishable, dependent: :destroy
  has_many :artist_contributions
  has_many :artist_names, dependent: :destroy

  delegate :approved?, :submitted?, :rejected?, to: :approval

  accepts_nested_attributes_for :artist_names,
                reject_if: proc { |attributes| attributes['name'].blank? },
                allow_destroy: true

  REJECTION_REASONS = [:not_rejected, :grammar_and_spelling, :incorrect_facts, :irrelevant_material, :not_related_to_theme, :not_acceptable]

  before_validation :assign_name_from_supplied_names
  validates :born_on, presence: true
  validate :death_after_birth, unless: "died_on == nil"
  validate :valid_country,     unless: "born_country_code == ''"

  enum gender: [:male, :female]

  scope :approved, -> { joins(:approval).where('approvals.approval_status = ?', Approval.approval_statuses[:approved]) }  
  scope :submitted, -> { joins(:approval).where('approvals.approval_status = ?', Approval.approval_statuses[:submitted]) }  
  scope :to_be_revised, -> { joins(:approval).where('approvals.approval_status = ?', Approval.approval_statuses[:to_be_revised]) }  
  scope :own_and_other_artists, -> (user_id) { 
    joins(:approval)
    .where("submitted_by_id = ? OR approvals.approval_status = ?", user_id, Approval.approval_statuses[:approved])
  }
   
  self.per_page = 10

  def load
    if self.persisted?
      @name_profile = NameProfile.new(artist_names)
      @name_profile.load_names
    end
  end

  def name
    assigned_name
  end

  def name_of_type( name_type )
    @names.get_name(name_type)
  end

  def historical_period_name
    historical_period ? historical_period.name : ""
  end

  def approval_status_display
    approval ? approval.approval_status.humanize : ""
  end

  def rejection_reason_display
    approval ? approval.rejection_reason.humanize : ""
  end

  private 

    def death_after_birth
      if born_on > died_on
        errors.add(:died_on, "Died before birth")
      end  
    end

    def valid_country
      unless I18n.t('countries').has_key?(born_country_code.to_sym)
        errors.add(:born_country_code, "Invalid country code")
      end
    end

    def assign_name_from_supplied_names
      names = artist_names.inject([]) { |names, name| names << name }
      @name_profile = NameProfile.new(names)
      if @name_profile.load_names
        self.assigned_name = @name_profile.assigned_name 
      else  
        errors.add(:assigned_name, @name_profile.error)
      end  
    end
end

