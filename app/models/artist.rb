class Artist < ActiveRecord::Base

  has_one :approval, as: :approvable, dependent: :destroy
  has_many :artist_names, dependent: :destroy
  has_many :articles, as: :publishable, dependent: :destroy
  accepts_nested_attributes_for :artist_names

  validates :born_on, presence: true

  validate :assign_name_from_supplied_names
  validate :death_after_birth, unless: "died_on == nil"
  validate :valid_country,     unless: "born_country_code == ''"

  enum gender: [:male, :female]

  def name
    names = artist_names.collect { |art_nme| art_nme.name }
    names.join(" ")
  end

  private 

    def death_after_birth
      errors.add(:died_on, "Died before birth")
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
