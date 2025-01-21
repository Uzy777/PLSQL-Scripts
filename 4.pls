-- Procedure to retrieve book details for a specific ISBN number within "books"
CREATE OR REPLACE PROCEDURE getBookDetails (
   p_isbn VARCHAR2,
   p_title OUT VARCHAR2,
   p_author OUT VARCHAR2,
   p_date_published OUT DATE,
   p_num_copies OUT NUMBER
) AS
BEGIN
-- Retrieves book details and the count of associated copies for a given ISBN.
   SELECT b.title, b.author, b.date_published, COUNT(bc.barcode_id)
   INTO p_title, p_author, p_date_published, p_num_copies
   FROM books b
   LEFT JOIN book_copies bc ON b.isbn = bc.isbn
   WHERE b.isbn = p_isbn
   GROUP BY b.title, b.author, b.date_published;
END;
/

-- Call the procedure and print book details for all records
DECLARE
   v_cursor SYS_REFCURSOR;  -- cursor allowes to go through all results
   v_isbn VARCHAR2(13); -- v used as a variable normal convention within PLSQL
   v_title VARCHAR2(200);
   v_author VARCHAR2(200);
   v_date_published DATE;
   v_num_copies NUMBER;
BEGIN
   -- Open a cursor to get all ISBNs from the "books" table
   OPEN v_cursor FOR
      SELECT isbn FROM books;

   -- Loop through the cursor and call the procedure for each ISBN inside "books" table
   LOOP
      FETCH v_cursor INTO v_isbn;
      EXIT WHEN v_cursor%NOTFOUND;

      getBookDetails(v_isbn, v_title, v_author, v_date_published, v_num_copies);
-- Output to us the following fixed and variable data
      DBMS_OUTPUT.PUT_LINE('Book Details for ISBN ' || v_isbn);
      DBMS_OUTPUT.PUT_LINE('Title: ' || v_title);
      DBMS_OUTPUT.PUT_LINE('Author: ' || v_author);
      DBMS_OUTPUT.PUT_LINE('Date Published: ' || TO_CHAR(v_date_published, 'DD-MON-YYYY'));
      DBMS_OUTPUT.PUT_LINE('Number of Copies: ' || v_num_copies);
      DBMS_OUTPUT.PUT_LINE('---------------------------');
   END LOOP;

   -- Close the cursor
   CLOSE v_cursor;
END;
/



-- TESTING
-- select * from books;
-- select * from book_copies;
