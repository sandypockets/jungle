RSpec.describe User, type: :model do
  describe "Validations" do
    it "should validate new user when passwords match" do
      user = User.create(first_name: "Bob", last_name: "Belcher", email: "bob@bobsburgers.com", password: "password", password_confirmation: "password")
      expect(user).to be_valid
    end

    it "should not validate new user when passwords do not match" do
      user = User.new(first_name: "Linda", last_name: "Belcher", email: "linda@bobsburgers.com", password: "Passworld", password_confirmation: "password")
      user.valid?
      errors = user.errors.full_messages
      expect(errors.length).to be(1)
      expect(errors[0]).to include("Password confirmation doesn't match Password")
    end

    it "should not validate new user when passwords are blank" do
      user = User.new(first_name: "Gene", last_name: "Belcher", email: "gene@bobsburgers.com", password: "", password_confirmation: "")
      user.valid?
      expect(user).to_not be_valid
      errors = user.errors.full_messages

      expect(errors[1]).to include("Password can't be blank")
    end

    it "should not validate if email is not unique" do
      user1 = User.create(first_name: "Louise", last_name: "Belcher", email: "louise@bobsburgers.com", password: "password", password_confirmation: "password")
      user2 = User.create(first_name: "Tina", last_name: "Belcher", email: "louise@bobsburgers.com", password: "password", password_confirmation: "password")
      user1.save
      user2.save
      errors = user2.errors.full_messages
      expect(errors.length).to be(1)
      expect(errors[0]).to include("Email has already been taken")
    end

    it "should not validate if email is not unique, even if the case of the text is different" do
      user1 = User.create(first_name: "Louise", last_name: "Belcher", email: "LOUISE@bobsburgers.com", password: "password", password_confirmation: "password")
      user2 = User.create(first_name: "Tina", last_name: "Belcher", email: "louise@bobsburgers.com", password: "password", password_confirmation: "password")
      user1.save
      user2.save
      errors = user2.errors.full_messages
      expect(errors.length).to be(1)
      expect(errors[0]).to include("Email has already been taken")
    end

    it "should require an email" do
      user = User.new(first_name: "Mister", last_name: "Fischoeder", email: "", password: "password", password_confirmation: "password")
      user.valid?
      errors = user.errors.full_messages
      expect(errors.length).to be(1)
      expect(errors[0]).to include("Email can't be blank")
    end

    it "should require first and last name" do
      user = User.create(first_name: "", last_name: "", email: "teddy@handyman.com", password: "password", password_confirmation: "password")
      user.valid?
      errors = user.errors.full_messages
      expect(errors.length).to be(2)
      expect(errors[0]).to include("First name can't be blank")
      expect(errors[1]).to include("Last name can't be blank")
    end

    it "should require password with a minimum length of 5 chars" do
      user = User.new(first_name: "Jimmy", last_name: "Pesto", email: "jimmy@jimmypestos.com", password: "pass", password_confirmation: "pass")
      user.valid?
      errors = user.errors.full_messages
      expect(errors.length).to be(1)
      expect(errors[0]).to include("Password is too short (minimum is 5 characters)")
    end


    describe ".authenticate_with_credentials" do
      it "should log in the user if credentials correct" do
        user1 = User.new(first_name: "Felix", last_name: "Fischoeder", email: "felix@wonderwharf.com", password: "password", password_confirmation: "password")
        user1.save
        user2 = User.authenticate_with_credentials("felix@wonderwharf.com", "password")
        expect(user1).to eql(user2)
      end

      it "should not log in the user in if credentials incorrect" do
        user1 = User.new(first_name: "Phillip", last_name: "Frond", email: "pfrond@wagstaff.edu", password: "password", password_confirmation: "password")
        user1.save
        user2 = User.authenticate_with_credentials("pfrond@wagstaff.edu", "wagstaffrules")
        expect(user1).to_not eql(user2)
      end

      it "should log in the user if credentials correct, even if email field contains whitespaces" do
        user1 = User.new(first_name: "Sergeant", last_name: "Bosco", email: "bosco@localpd.com", password: "password", password_confirmation: "password")
        user1.save
        user2 = User.authenticate_with_credentials(" bosco@localpd.com ", "password")
        expect(user1).to eql(user2)
      end

      it "should log in the user if credentials correct, even if casing is different" do
        user1 = User.new(first_name: "Mort", last_name: "Mortician", email: "mort@itsyourfuneralandcrematorium.com", password: "password", password_confirmation: "password")
        user1.save
        user2 = User.authenticate_with_credentials("MORT@itsyourfuneralANDcrematorium.COM", "password")
        expect(user1).to eql(user2)
      end

    end

  end
end
