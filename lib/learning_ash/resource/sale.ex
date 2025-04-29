defmodule LearningAsh.Resource.Sale do
  use Ash.Resource,
    domain: LearningAsh.ResourceDomain,
    authorizers: Ash.Policy.Authorizer,
    extensions: [AshAuthentication, AshGraphql.Resource],
    data_layer: AshPostgres.DataLayer

  graphql do
    type :sale

    queries do
      get :get_sale, :read
      list :list_sale, :read
    end

    mutations do
      create :create_sale, :create
      update :update_sale, :update
      destroy :destroy_sale, :destroy
    end
  end

  postgres do
    table "sale"
    repo LearningAsh.Repo
  end

  actions do
    defaults [:read, :destroy, update: :*]

    create :create do
      accept [
        :buyer_name,
        :seller_name,
        :product_name,
        :quantity,
        :unity_price,
        :product_desc
      ]

      change(fn changeset, _ ->
        quantity = Ash.Changeset.get_attribute(changeset, :quantity)
        unity_price = Ash.Changeset.get_attribute(changeset, :unity_price)

        if (quantity && unity_price) do
          total_price = quantity * unity_price
          Ash.Changeset.change_attribute(changeset, :total_price, total_price)
        else
          changeset
        end
      end)
    end
  end

  attributes do
    uuid_v7_primary_key :id
    attribute :buyer_name, :string, allow_nil?: false, public?: true
    attribute :seller_name, :string, allow_nil?: false, public?: true
    attribute :product_name, :string, allow_nil?: false, public?: true
    attribute :quantity, :integer, allow_nil?: false, public?: true
    attribute :unity_price, :float, allow_nil?: false, public?: true
    attribute :total_price, :float, allow_nil?: false, public?: true
    attribute :product_desc, :string, allow_nil?: false, public?: true

    create_timestamp :sale_date
  end
end
