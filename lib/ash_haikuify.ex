# lib/framework/extensions/ash_parental/ash_parental.ex
defmodule AshHaikuify do
  @moduledoc """
    An Ash extension that adds haiku style slugs to a resource.
  """

  use Spark.Dsl.Extension, imports: [AshHaikuify.Changes]
end
