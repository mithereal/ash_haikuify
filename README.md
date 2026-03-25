
# Getting Started With Ash Haikuify

Ash Haikuify is an Ash Framework extension that slugifys resources in haiku style

## Installation

The package can be installed by adding `ash_haikuify` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ash_haikuify, "~> 0.0.0"}
  ]
end
```

Then add it to your resource like below

```elixir
defmodule MyApp.Tenant do
    use Ash.Resource, extensions: [AshHaikuify]
    
    attributes do
    uuid_v7_primary_key :id

    attribute :prefix, :string do
      allow_nil? false
      public? true
      description "Table prefix for the Tenant"
    end
    
    actions do
    create :create do
      change haikuify(token: "this-will-append-the-haiku", into: :prefix)
    end
  end
end
# or
defmodule MyApp.Tenant do
    use Ash.Resource, extensions: [AshHaikuify]
    
    attributes do
    uuid_v7_primary_key :id

    attribute :name, :string do
      allow_nil? false
      public? true
      description "Name of the tenant"
    end
    
    attribute :prefix, :string do
      allow_nil? false
      public? true
      description "Table prefix for the tenant"
    end
    
    actions do
    create :create do
      change haikuify(:name, [into: :prefix])
    end
  end
end
```
