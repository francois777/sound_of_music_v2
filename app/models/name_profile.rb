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
    return false unless add_names
    return false unless sufficient_names?
    assign_name
    @assigned_name.present?
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

    def sufficient_names?
      if @selected_names.empty?
        @error = "No names have been provided"
      elsif @public_name.empty? and (@first_name.empty? or @last_name.empty?)
        @error = "Insufficient names are provided" 
      end  
      @error.nil?
    end

    def add_names
      @names.each { |name| add_name(name) }
      @error.nil?
    end

    def add_name(name)
      if name.name.empty?
        @error = "#{name.name_type.humanize} is missing" 
      else  
        send("add_#{name.name_type}", name.name)
      end
    end

    def add_first_name(name)
      if @first_name.empty?
        @first_name = name
        @selected_names << @first_name
      else        
        @error = "Only one first name is allowed" 
      end
    end

    def add_last_name(name)
      if @last_name.empty?
        @last_name = name
        @selected_names << @last_name
      else        
        @error = "Only one last name is allowed" 
      end
    end

    def add_public_name(name)
      if @public_name.empty?
        @public_name = name
        @selected_names << @public_name
      else        
        @error = "Only one public name is allowed" 
      end
    end

    def add_maiden_name(name)
      if @maiden_name.empty?
        @maiden_name = name
        @selected_names << @maiden_name
      else        
        @error = "Only one maiden name is allowed" 
      end
    end

    def add_middle_name(name)
      if @middle_names.size > 2
        @error = "A maximum of 3 middle names are allowed"
      else
        @middle_names << name
        @selected_names << name
      end
    end

    def selected_names
      names = []
      names << @first_name if @first_name
      names << @middle_names.join(" ") if @middle_names.any?
      names << @last_name if @last_name
    end

end