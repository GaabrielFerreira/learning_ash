defmodule LearningAsh.ResourceDomain do
  use Ash.Domain,
    extensions: [
      AshGraphql.Domain
    ]

  graphql do
    root_level_errors? true
    authorize? false
  end

  resources do
    resource LearningAsh.Resource.Sale
  end
end
