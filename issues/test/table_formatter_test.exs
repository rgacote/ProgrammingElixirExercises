defmodule TableFormatterTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  alias Issues.TableFormatter, as: TF

  describe("Basic Tests") do
    setup do
      [
        tickets: [
          %{"number" => 3, "title" => "title 3", "ignore" => 123, "silly" => 345},
          %{"number" => 1, "title" => "nice title", "ignore" => 123, "silly" => 345}
        ],
        headers: ["number", "title"]
      ]
    end

    test "extract rows", fixture do
      data = TF.extract_rows(fixture.tickets, fixture.headers)

      assert data == [
               %{"number" => 3, "title" => "title 3"},
               %{"number" => 1, "title" => "nice title"}
             ]
    end

    test "extracted rows column widths", fixture do
      rows = TF.extract_rows(fixture.tickets, fixture.headers)

      col_widths =
        TF.rows2columns(rows, fixture.headers)
        |> TF.col_widths()

      assert length(col_widths) == length(fixture.headers)
      assert col_widths == [1, 10]
    end

    test "pivot rows to columns", fixture do
      rows = TF.extract_rows(fixture.tickets, fixture.headers)

      columns = TF.rows2columns(rows, fixture.headers)

      assert length(columns) == length(fixture.headers)
      assert List.first(columns) == ["3", "1"]
      assert List.last(columns) == ["title 3", "nice title"]
    end

    test "print one column", fixture do
      column = TF.size_col("hello", 10)
      assert String.length(column) == 10
    end
  end
end
