# NameProfile validates the collection of all names provided
# and provides a suitable assigned name
class NameProfile
  attr_accessor :assigned_name, :first_name, :middle_names, :last_name,
                :public_name, :maiden_name, :error

  def initialize(names)
    @names = names
    @selected_names = []
    @error = nil
    @first_name = ""
    @last_name = ""
    @public_name = ""
    @maiden_name = ""
    @middle_names = []
    @assigned_name = ""
  end

  def load_names
    add_names
    check_sufficient_names
    assign_name
  end

  def get_name( name_type )
    send(name_type.to_s)
  end

  def birth_names
    [@first_name, @middle_names, @last_name].flatten.join(" ").strip
  end

  private

    def assign_name
      if @public_name.present?
        @assigned_name = @public_name
      else  
        @assigned_name = birth_names
      end  
    end

    def check_sufficient_names   
      raise "No names have been provided" if @selected_names.empty?
      raise "Insufficient names are provided" if @public_name.empty? and (@first_name.empty? or @last_name.empty?)
    end

    def add_names
      @names.each { |name| add_name(name) }
    end

    def add_name(name)
      raise "#{name.name_type.humanize} is missing" if name.name.empty?
      send("add_#{name.name_type}", name.name)
    end

    def add_first_name(name)
      raise "Only one first name is allowed" if @first_name.present?
      @first_name = name
      @selected_names << @first_name
    end

    def add_last_name(name)
      raise "Only one last name is allowed" if @last_name.present?
      @last_name = name
      @selected_names << @last_name
    end

    def add_public_name(name)
      raise "Only one public name is allowed" if @public_name.present?
      @public_name = name
      @selected_names << @public_name
    end

    def add_maiden_name(name)
      raise "Only one maiden name is allowed" if @maiden_name.present?
      @maiden_name = name
      @selected_names << @maiden_name
    end

    def add_middle_name(name)
      raise "A maximum of 3 middle names are allowed" if @middle_names.size > 2
      @middle_names << name
      @selected_names << name
    end

    def selected_names
      names = []
      names << @first_name if @first_name
      names << @middle_names.join(" ") if @middle_names.any?
      names << @last_name if @last_name
    end

end