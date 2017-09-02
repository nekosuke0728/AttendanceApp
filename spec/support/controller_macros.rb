module ControllerMacros

#   def login_admin(admin)
#     before(:each) do
#       @request.env["devise.mapping"] = Devise.mappings[:admin]
#       admin = create(:admin)
#       sign_in :user, admin
#     end
#   end
 
#   def login_user(user)
#     before(:each) do
#       @request.env["devise.mapping"] = Devise.mappings[:user]
#       user = create(:user)
#       sign_in user
#     end
#   end

#   def login_admin(admin)
#     allow(controller).to receive(:authenticate_admin!).and_return true
#     @request.env["devise.mapping"] = Devise.mappings[:admin]
#     sign_in admin
#   end

#   def login_user(user)
#     allow(controller).to receive(:authenticate_user!).and_return true
#     @request.env["devise.mapping"] = Devise.mappings[:user]
#     sign_in user
#   end

#   # def login_user(user)
#   #   @request.env["devise.mapping"] = Devise.mappings[:user]
#   #   user ||= create(:user)
#   #   sign_in user
#   # end

#   def login_user(user=nil)
#     @request.env["devise.mapping"] = Devise.mappings[:user]
#     user ||= FactoryGirl.create(:user)
#     sign_in user
#   end

#   def login_admin(admin=nil)
#     @request.env["devise.mapping"] = Devise.mappings[:admin]
#     admin ||= FactoryGirl.create(:admin)
#     sign_in admin
#   end

end