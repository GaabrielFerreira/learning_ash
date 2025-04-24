defmodule LearningAsh.Secrets do
  use AshAuthentication.Secret

  def secret_for(
        [:authentication, :tokens, :signing_secret],
        LearningAsh.Accounts.User,
        _opts,
        _context
      ) do
    Application.fetch_env(:learning_ash, :token_signing_secret)
  end
end
