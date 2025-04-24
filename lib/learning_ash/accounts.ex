defmodule LearningAsh.Accounts do
  use Ash.Domain,
    otp_app: :learning_ash

  resources do
    resource LearningAsh.Accounts.Token
    resource LearningAsh.Accounts.User
  end
end
