defmodule LearningAsh.Accounts do
  use Ash.Domain,
    extensions: [
      AshGraphql.Domain
    ]

  graphql do
    root_level_errors? true
    authorize? true
  end

  resources do
    resource LearningAsh.Accounts.Token
    resource LearningAsh.Accounts.User
  end
end
