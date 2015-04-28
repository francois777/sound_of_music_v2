class Artist < ActiveRecord::Base

  belongs_to :submitted_by, class_name: 'User'
  belongs_to :historical_period
  has_one :approval, as: :approvable, dependent: :destroy
  has_many :artist_names, dependent: :destroy
  has_many :articles, as: :publishable, dependent: :destroy
  has_many :artist_contributions

  REJECTION_REASONS = [:not_rejected, :grammar_and_spelling, :incorrect_facts, :irrelevant_material, :not_related_to_theme, :not_acceptable]

  accepts_nested_attributes_for :artist_names,
                reject_if: proc { |attributes| attributes['name'].blank? },
                allow_destroy: true

  validates :born_on, presence: true
  validate :assign_name_from_supplied_names
  validate :death_after_birth, unless: "died_on == nil"
  validate :valid_country,     unless: "born_country_code == ''"

  enum gender: [:male, :female]

  scope :approved, -> { joins(:approval).where('approvals.approval_status = ?', Approval.approval_statuses[:approved]) }  
  scope :submitted, -> { joins(:approval).where('approvals.approval_status = ?', Approval.approval_statuses[:submitted]) }  
  scope :to_be_revised, -> { joins(:approval).where('approvals.approval_status = ?', Approval.approval_statuses[:to_be_revised]) }  
  scope :own_and_other_artists, -> (user_id) { 
    joins(:approval).
    where("submitted_by_id = ? OR approvals.approval_status = ?", user_id, Approval.approval_statuses[:approved])
  }
   
  self.per_page = 10

  def name
    assigned_name
  end

  def historical_period_name
    historical_period ? historical_period.name : ""
  end

  def historical_period_id
    historical_period ? historical_period.id : 1
  end 

  def birth_names
    [first_name, middle_names, last_name].flatten.join(" ")
  end

  def first_name
    fnme = artist_names.where("name_type = ?", ArtistName.name_types[:first_name]).first
    fnme ? fnme.name : ""
  end

  def middle_names
    middle_names = artist_names.where("name_type = ?", ArtistName.name_types[:middle_name])
    middle_names.map(&:name)
  end

  def last_name
    lnme = artist_names.where("name_type = ?", ArtistName.name_types[:last_name]).first
    lnme ? lnme.name : ""
  end

  def maiden_name
    mnme = artist_names.where("name_type = ?", ArtistName.name_types[:maiden_name]).first
    mnme ? mnme.name : ""
  end

  def public_name
    pnme = artist_names.where("name_type = ?", ArtistName.name_types[:public_name]).first
    pnme ? pnme.name : ""
  end

  def approval_status_display
    approval.approval_status.humanize if approval
  end

  def rejection_reason_display
    approval.rejection_reason.humanize if approval
  end

  def approved?
    approval.approved?
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
      first_name_count = middle_name_count = last_name_count = public_name_count = maiden_name_count = 0
      first_name = last_name = public_name = maiden_name = ""
      middle_names = []
      if artist_names.size == 0
        errors.add(:assigned_name, "No names provided")
        return
      end
      artist_names.each do |name|
        if name.name.empty?
          errors.add(:assigned_name, "Some name was not specified")
          break
        end
        case name.name_type
        when 'first_name'
          first_name_count += 1
          first_name = name.name
        when 'last_name'
          last_name_count += 1
          last_name = name.name
        when 'public_name'
          public_name_count += 1
          public_name = name.name
        when 'maiden_name'
          maiden_name_count += 1
          maiden_name = name.name
        when 'middle_name'
          middle_names << name.name
          middle_name_count += 1
        end
      end  
      if first_name_count > 1 or last_name_count > 1 or public_name_count > 1 or maiden_name_count > 1
        errors.add(:assigned_name, "Only one name is allowed for first name, last name, public name or maiden name")
      end
      if middle_name_count > 3
        errors.add(:assigned_name, "A maximum of 3 middle names are allowed")
      end
      unless public_name.present?
        unless first_name.present? and last_name.present?
          errors.add(:assigned_name, "First and last name are required")
        end
      end
      return if errors.count > 0
      if public_name.present?
        self.assigned_name = public_name
      else
        names = []
        names << first_name if first_name.present?
        names << middle_names.join(" ") if middle_names.any?
        names << last_name if last_name.present?
        self.assigned_name = names.join(" ")
      end
    end
end
