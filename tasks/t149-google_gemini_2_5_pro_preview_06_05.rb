
select { |str| str.length.even? }` does this.
    *   Sorts by length, then alphabetically: `sort_by { |str| [
str.length, str] }` does this.
*   **Return value