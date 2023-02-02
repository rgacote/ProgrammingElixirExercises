defmodule Issues.TableFormatter do
  @moduledoc """
  Print top-level JSON attributes as ASCII table.

  Provide proper right-padding so columns align.

  Example:
   #  | created_at          | title
  ----+---------------------+--------------
  123 | 2023-01-01T22:10:01 | Ticket title
  123 | 2023-01-01T10:10:01 | Earlier ticket

  Steps to take
  1. Extract data columns from JSON.
  2. Find maximum width for each column.
  3. Determine how to form proper-width columns by row (Enum.zip?)
  4. Display proper-width heading, separator, and data rows.
  """

  @doc """
  Print the table.

  Return the ticket list for future processing.
  """
  def print_table(tickets, headers) do
    printables =
      tickets
      |> extract_rows(headers)

    column_widths =
      printables
      |> rows2columns(headers)
      |> col_widths

    # Tuple of header/width.
    column_widths = Enum.zip(headers, column_widths)

    IO.puts(table_header(column_widths))
    IO.puts(table_separator(column_widths))

    printables
    |> print_tickets(column_widths)
  end

  @doc """
  Fetch data from map.
  Default to empty string.
  """
  def fetch(header, map) do
    with data <- Map.get(map, header) do
      "#{elem(data, 1)}"
    else
      :error ->
        ""
    end
  end

  @doc """
  Extract only the data in which we're interested.

  Returns list of maps.
  """
  @spec extract_rows(list(map), list) :: list
  def extract_rows(rows, headers) do
    Enum.map(rows, fn row -> extract_row(row, headers) end)
  end

  @doc """
  Create map of just the header elements for each row.

  The row contains a map.
  Create a list of header/value tuples.

  """
  def extract_row(row, headers) do
    Enum.map(headers, fn header -> {header, Map.get(row, header)} end)
    |> Enum.into(%{})
  end

  @doc """
  List of columns.

  Each list contains one column as a string.
  Column order is important.
  """
  @spec rows2columns(list(map), list) :: list
  def rows2columns(tickets, headers) do
    for header <- headers do
      for ticket <- tickets do
        "#{Map.get(ticket, header, "")}"
      end
    end
  end

  def col_widths(columns) do
    for column <- columns do
      column
      |> Enum.map(&String.length/1)
      |> Enum.max()
    end
  end

  @doc """
  Print the report header row.

  column_widths contains tuples of header name and width.
  Header 'number' should be changed to '#'.

  ## Example
    iex> column_widths = [{"number", 3}, {"created_at", 12}, {"title", 15} ]
    iex> Issues.TableFormatter.table_header(column_widths)
    "#   | created_at   | title          "
  """
  def table_header(column_widths) do
    cols =
      for {header, width} <- column_widths do
        size_col(header, width, :header_row)
      end

    Enum.join(cols, " | ")
  end

  @doc """
  Generate the line between table header and body.any()

  ## Example
    iex> column_widths = [{"number", 3}, {"created_at", 10}, {"title", 15} ]
    iex> Issues.TableFormatter.table_separator(column_widths)
    "----+------------+----------------"
  """
  def table_separator(column_widths) do
    cols =
      for {_, width} <- column_widths do
        String.pad_trailing("-", width, "-")
      end

    Enum.join(cols, "-+-")
  end

  def print_tickets(tickets, column_widths) do
    Enum.map(tickets, fn ticket -> print_ticket(ticket, column_widths) end)
  end

  @doc """
  Print the properly-sized row.
  """
  def print_ticket(ticket, col_widths) do
    cols =
      for {header, width} <- col_widths do
        size_col(ticket[header], width)
      end

    row = Enum.join(cols, " | ")
    IO.puts(row)
  end

  @doc """
  Size a single column.
  """
  def size_col(value, width) when is_binary(value) do
    String.pad_trailing(value, width)
  end

  def size_col(value, width) do
    String.pad_trailing(to_string(value), width)
  end

  def size_col("number", width, :header_row) do
    String.pad_trailing("#", width)
  end

  def size_col(value, width, :header_row) do
    String.pad_trailing("#{value}", width)
  end
end
