class ContributionType < ActiveRecord::Base

  has_many :artist_contributions

  enum classification: [:arranger, :band_leader, :composer, :conductor, :group_of_musicians, :librettist, :lyricist, :playwright, :poet, :screenwriter, :songwriter, :vocalist]
  enum group_type: [:individual, :a_capella_choir, :band, :orchestra, :choir, :instrumental_group, :vocal_group]
  enum voice_type: [:not_applicable, :alto, :baritone, :bass, :contraldo, :countertenor, :mezzo_soprano, :soprano, :tenor]

  before_validation :set_types
  before_save :assign_name

  validates :definition, presence: true,
                   uniqueness: { case_sensitive: false },
                   length: { minimum: 10 }
  validates_uniqueness_of :classification, scope: [:group_type, :voice_type]               
  validate :group_type_required, if: :group_of_musicians?
  validate :voice_type_required, if: :vocalist?
  validate :group_type_only_for_group
  validate :voice_type_only_for_vocalist

  private

    def assign_name
      case classification
      when 'group_of_musicians'
        self.name = group_type.humanize
      when 'vocalist'
        self.name = "#{voice_type.humanize} voice"
      else
        self.name = classification.humanize
      end    
    end

    def set_types
      case classification
      when 'group_of_musicians'
        self.voice_type = :not_applicable
      when 'vocalist'
        self.group_type = :individual
      else
        self.voice_type = :not_applicable
        self.group_type = :individual        
      end
    end

    def group_type_required
      errors.add(:group_type, 'A group type must be selected') if group_type == 'individual'
    end

    def voice_type_required
      errors.add(:voice_type, 'A voice type must be selected') if voice_type == 'not_applicable'
    end

    def group_type_only_for_group
      if classification != 'group_of_musicians' and group_type != 'individual'
        errors.add(:group_type, "A group type does not apply to #{classification}")
      end
    end

    def voice_type_only_for_vocalist
      if classification != 'vocalist' and voice_type != 'not_applicable'
        errors.add(:voice_type, "A voice type does not apply to #{classification}")
      end
    end    

end