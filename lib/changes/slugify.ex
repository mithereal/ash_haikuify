defmodule AshHaikuify.Changes.Slugify do
  use Ash.Resource.Change

  @opt_schema [
    attribute: [
      doc: "The attribute to slugify.",
      required: false,
      type: :atom
    ],
    token: [
      doc: "The token to slugify.",
      required: false,
      type: :string
    ],
    into: [
      doc:
        "The attribute to store the slug in. Unless specified, the slug will be stored in the same attribute.",
      type: :atom,
      required: false
    ],
    separator: [
      doc: "The separator to use between words in the slug.",
      type: :string,
      default: "-"
    ],
    skip_if_present?: [
      doc: "Skip slug generation when the destination attribute is already being changed.",
      type: :boolean,
      default: false
    ]
  ]

  def opt_schema, do: @opt_schema

  @impl true
  def init(opts) do
    case Spark.Options.validate(opts, opt_schema()) do
      {:ok, opts} -> {:ok, opts}
      {:error, error} -> {:error, Exception.message(error)}
    end
  end

  @impl true
  def change(changeset, opts, _) do
    with {attribute, opts} <- Keyword.pop(opts, :attribute),
         {token, opts} <- Keyword.pop(opts, :token),
         {separator, opts} <- Keyword.pop(opts, :separator),
         {into, opts} <- Keyword.pop(opts, :into, attribute),
         {skip_if_present?, _opts} <- Keyword.pop(opts, :skip_if_present?),
         {:ok, value} when is_binary(value) <- get_attribute(changeset, attribute, token),
         slug <- slugify(value, separator) do
      if skip_if_present? && Ash.Changeset.changing_attribute?(changeset, into) do
        changeset
      else
        changeset
        |> Ash.Changeset.force_change_attribute(into, slug)
      end
    else
      {:ok, _} ->
        Ash.Changeset.add_error(changeset,
          field: opts[:attribute],
          message: "is not a string value"
        )

      :error ->
        changeset
    end
  end

  defp get_attribute(changeset, attribute, token) do
    case token do
      nil ->
        if is_nil(attribute) do
          {:ok, nil}
        else
          case Ash.Changeset.fetch_argument_or_change(changeset, attribute) do
            {:ok, %Ash.CiString{} = value} -> {:ok, Ash.CiString.value(value)}
            err -> err
          end
        end

      token ->
        {:ok, token}
    end
  end

  defp slugify(name, separator) do
    name
    |> String.downcase()
    |> Haikuify.build(separator)
  end
end
