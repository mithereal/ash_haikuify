defmodule AshHaikuify.Changes do
  alias AshHaikuify

  @moduledoc """
  Change functions for the `AshHaikuify` extension.
  """

  @doc """
  Slugify a string attribute on a changeset.

  ## Options

  #{Spark.Options.docs(AshHaikuify.Changes.Slugify.opt_schema())}

  ## Examples

      change haikuify(token: "text")
      change haikuify(token: "text", into: :domain)
  """
  def haikuify(attribute, opts) do
    {AshHaikuify.Changes.Slugify, Keyword.merge(opts, attribute: attribute)}
  end

  def haikuify(opts \\ []) do
    {AshHaikuify.Changes.Slugify, opts}
  end
end
