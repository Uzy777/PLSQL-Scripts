-- Store data within a new table "getBookDetails"
CREATE OR REPLACE PROCEDURE getBookDetails (
   p_isbn VARCHAR2, -- p used as a parameter normal convention within PLSQL
   p_title OUT VARCHAR2,
   p_author OUT VARCHAR2,
   p_date_published OUT DATE,
   p_num_copies OUT NUMBER
) AS
BEGIN
-- Retrieves book details and the count of associated copies for a given ISBN.
   SELECT b.title, b.author, b.date_published, COUNT(bc.barcode_id) INTO p_title, p_author, p_date_published, p_num_copies
   FROM books b
   LEFT JOIN book_copies bc ON b.isbn = bc.isbn
   WHERE b.isbn = p_isbn
   GROUP BY b.title, b.author, b.date_published;
END;
/

-- Calling the procedure and displaying the from "getBookDetails"
DECLARE
   v_title VARCHAR2(200);   -- v used as a variable normal convention within PLSQL
   v_author VARCHAR2(200);
   v_date_published DATE;
   v_num_copies NUMBER;
BEGIN
   getBookDetails('1-56592-335-9', v_title, v_author, v_date_published, v_num_copies); -- CHANGE ISBN TO DISPLAY NUMBER OF COPIES
-- Output to us the following fixed and variable data
   DBMS_OUTPUT.PUT_LINE('Title: ' || v_title);
   DBMS_OUTPUT.PUT_LINE('Author: ' || v_author);
   DBMS_OUTPUT.PUT_LINE('Date Published: ' || TO_CHAR(v_date_published, 'DD-MON-YYYY'));
   DBMS_OUTPUT.PUT_LINE('Number of Copies: ' || v_num_copies);
END;
/



-- TESTING
-- select * from books;
-- select * from book_copies;
