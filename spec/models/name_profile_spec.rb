require 'spec_helper'

describe NameProfile do

  context "Without errors" do

    describe "provide first name, last name and maiden name" do
      before do
        @names = [ArtistName.new(name: 'Gertruida', name_type: :first_name),
                  ArtistName.new(name: 'Goosen', name_type: :last_name),
                  ArtistName.new(name: 'Joubert', name_type: :maiden_name)
                 ]
        @profile = NameProfile.new(@names)
      end

      it "must be valid" do
        begin
          result = @profile.load_names
          expect( @profile.assigned_name ).to eq('Gertruida Goosen')
          expect( @profile.maiden_name).to eq('Joubert')
        rescue Exception => e
          expect(e.message).to be_nil
        end  
      end
    end

    describe "provide first, middle and last name" do
      before do
        @names = [ArtistName.new(name: 'Gert', name_type: :first_name),
                  ArtistName.new(name: 'Poggies', name_type: :middle_name),
                  ArtistName.new(name: 'Poggenpoel', name_type: :last_name)]
        @profile = NameProfile.new(@names)
      end

      it "must be valid" do
        begin
          result = @profile.load_names
          expect( @profile.assigned_name ).to eq('Gert Poggies Poggenpoel')
        rescue Exception => e
          expect(e.message).to be_nil
        end  
      end
    end

    describe "provide as many names as possible" do
      before do
        @names = [ArtistName.new(name: 'Gert', name_type: :first_name),
                  ArtistName.new(name: 'Koos', name_type: :middle_name),
                  ArtistName.new(name: 'Piet', name_type: :middle_name),
                  ArtistName.new(name: 'Jan', name_type: :middle_name),
                  ArtistName.new(name: 'Poggenpoel', name_type: :last_name),
                  ArtistName.new(name: 'GKP Poggies', name_type: :public_name),
                ]
        @profile = NameProfile.new(@names)
      end

      it "must be valid" do
        begin
          result = @profile.load_names
          expect( @profile.first_name ).to eq('Gert')
          expect( @profile.middle_names ).to eq(['Koos', 'Piet', 'Jan'])
          expect( @profile.assigned_name ).to eq('GKP Poggies')
          birth_names = @profile.get_name(:birth_names)
        rescue Exception => e
          expect(e.message).to be_nil
        end  
      end
    end

    describe "First name absent but public name present" do
      before do
        @names = [ArtistName.new(name: 'Gert', name_type: :middle_name),
                  ArtistName.new(name: 'Gertjie', name_type: :public_name),
                  ArtistName.new(name: 'Poggenpoel', name_type: :last_name)]
        @profile = NameProfile.new(@names)
      end

      it "uses public name if first name is missing" do
        begin
          result = @profile.load_names
          expect( @profile.assigned_name ).to eq('Gertjie')
        rescue Exception => e
          expect(e.message).to be_nil
        end  
      end
    end    

    describe "Last name absent but public name present" do
      before do
        @names = [ArtistName.new(name: 'Gert', name_type: :middle_name),
                  ArtistName.new(name: 'Gertjie', name_type: :public_name),
                  ArtistName.new(name: 'Poggenpoel', name_type: :first_name)]
        @profile = NameProfile.new(@names)
      end

      it "uses public name if first name is missing" do
        begin
          result = @profile.load_names
          expect( @profile.assigned_name ).to eq('Gertjie')
        rescue Exception => e
          expect(e.message).to be_nil
        end  
      end
    end
  end

  context "With errors" do

    describe "No names provided" do
      before do
        @names = [ArtistName.new(name: '', name_type: :first_name),
                  ArtistName.new(name: '', name_type: :last_name)]
        @profile = NameProfile.new(@names)
      end

      it "regards 'no names' as an error" do
        begin
          result = @profile.load_names
        rescue Exception => e
          expect( e.message ).to eq("First name is missing")
          expect( @profile.assigned_name ).to eq('')
        end  
      end
    end

    describe "One blank name provided" do
      before do
        @names = [ArtistName.new(name: 'Gert', name_type: :first_name),
                  ArtistName.new(name: '', name_type: :middle_name),
                  ArtistName.new(name: 'Poggenpoel', name_type: :last_name)]
        @profile = NameProfile.new(@names)
      end

      it "regards a blank name as an error" do
        begin
          result = @profile.load_names
        rescue Exception => e
          expect( e.message ).to eq("Middle name is missing")
          expect( @profile.assigned_name ).to eq('')
        end
      end
    end

    describe "Neither First name nor public name provided" do
      before do
        @names = [ArtistName.new(name: 'Jan', name_type: :middle_name),
                  ArtistName.new(name: 'Poggenpoel', name_type: :last_name)]
        @profile = NameProfile.new(@names)
      end

      it "regards a missing first name as an error" do
        begin
          result = @profile.load_names
        rescue Exception => e
          expect( e.message ).to eq("Insufficient names are provided")
          expect( @profile.assigned_name ).to eq('')
        end
      end
    end

    describe "Neither Last name nor public name provided" do
      before do
        @names = [ArtistName.new(name: 'Jan', name_type: :middle_name),
                  ArtistName.new(name: 'Piet', name_type: :first_name)]
        @profile = NameProfile.new(@names)
      end

      it "regards a missing last name as an error" do
        begin
          result = @profile.load_names
        rescue Exception => e
          expect( e.message ).to eq("Insufficient names are provided")
          expect( @profile.assigned_name ).to eq('')
        end
      end
    end

    describe "Two first names provided" do
      before do
        @names = [ArtistName.new(name: 'Jan', name_type: :first_name),
                  ArtistName.new(name: 'Piet', name_type: :first_name),
                  ArtistName.new(name: 'Poggenpoel', name_type: :last_name)
                 ]
        @profile = NameProfile.new(@names)
      end

      it "cannot have two first names" do
        begin 
          result = @profile.load_names
        rescue Exception => e
          expect( e.message ).to eq("Only one first name is allowed")
          expect( @profile.assigned_name ).to eq('')
        end
      end
    end

    describe "Two last names provided" do
      before do
        @names = [ArtistName.new(name: 'Jan', name_type: :first_name),
                  ArtistName.new(name: 'Piet', name_type: :first_name),
                  ArtistName.new(name: 'Poggenpoel', name_type: :last_name),
                  ArtistName.new(name: 'Pootjies', name_type: :last_name)
                 ]
        @profile = NameProfile.new(@names)
      end

      it "cannot have two last names" do
        begin
          result = @profile.load_names
        rescue Exception => e
          expect( e.message ).to eq("Only one first name is allowed")
          expect( @profile.assigned_name ).to eq('')
        end
      end
    end

    describe "Two maiden names provided" do
      before do
        @names = [ArtistName.new(name: 'Gertruida', name_type: :first_name),
                  ArtistName.new(name: 'Goosen', name_type: :last_name),
                  ArtistName.new(name: 'Jacobson', name_type: :maiden_name),
                  ArtistName.new(name: 'Joubert', name_type: :maiden_name)
                 ]
        @profile = NameProfile.new(@names)
      end

      it "cannot have two maiden names" do
        begin
          result = @profile.load_names
        rescue Exception => e
          expect( e.message ).to eq("Only one maiden name is allowed")
          expect( @profile.assigned_name ).to eq('')
        end
      end
    end

    describe "Two public names provided" do
      before do
        @names = [ArtistName.new(name: 'Gertruida', name_type: :first_name),
                  ArtistName.new(name: 'Goosen', name_type: :last_name),
                  ArtistName.new(name: 'Jacobson', name_type: :maiden_name),
                  ArtistName.new(name: 'Jenkins', name_type: :public_name),
                  ArtistName.new(name: 'Joubert', name_type: :public_name)
                 ]
        @profile = NameProfile.new(@names)
      end

      it "cannot have two public names" do
        begin
          result = @profile.load_names
        rescue Exception => e
          expect( e.message ).to eq("Only one public name is allowed")
          expect( @profile.assigned_name ).to eq('')
        end
      end
    end
  end
end
