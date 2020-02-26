class Users::RegistrationsController < Devise::RegistrationsController
# 各アクションをオーバーライド
def cansel
  super
end

def create
  super
  ThanksMailer.registration_confirmation(resource).deliver unless resource.invalid?
end

def new
  super
end

def edit
  super
end

def update
  super
end

def destroy
  super
end

end
