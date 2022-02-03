CREATE OR REPLACE PROCEDURE UPDATE_BOOK_INFO (
			ARG_ISBN IN VARCHAR2,
			ARG_BOOKNAME IN VARCHAR2,
			ARG_AUTHOR_ID IN NUMBER,
			ARG_EDITION IN VARCHAR2,
			ARG_RELEASE_DATE IN DATE,
			ARG_PRICE IN NUMBER,
			ARG_PAGE_COUNT IN NUMBER,
			ARG_QUANTITY IN NUMBER,
			ARG_PUBLISHER_ID IN NUMBER
			) IS
		CNT_BOOK NUMBER;
		CNT_AUTHOR NUMBER;
		CNT_PUBLISHER NUMBER;
		CNT_PK_IN_WRITES NUMBER;
	BEGIN
		SELECT COUNT(*) INTO CNT_BOOK FROM BOOKS WHERE ISBN=ARG_ISBN;
		SELECT COUNT(*) INTO CNT_AUTHOR FROM AUTHORS WHERE AUTHOR_ID=ARG_AUTHOR_ID;
		SELECT COUNT(*) INTO CNT_PUBLISHER FROM PUBLISHERS WHERE PUBLISHER_ID=ARG_PUBLISHER_ID;
		SELECT COUNT(*) INTO CNT_PK_IN_WRITES FROM WRITES WHERE AUTHOR_ID = ARG_AUTHOR_ID AND ISBN = ARG_ISBN;

		IF CNT_BOOK <> 0 AND CNT_AUTHOR <> 0 AND CNT_PUBLISHER <> 0 THEN
			UPDATE BOOKS
			SET
				NAME = INITCAP(ARG_BOOKNAME),
				EDITION = INITCAP(ARG_EDITION),
				RELEASE_DATE = ARG_RELEASE_DATE,
				PRICE = ARG_PRICE,
				PAGE_COUNT = ARG_PAGE_COUNT,
				QUANTITY = ARG_QUANTITY,
				PUBLISHER_ID = ARG_PUBLISHER_ID
			WHERE ISBN=ARG_ISBN;

			IF CNT_PK_IN_WRITES = 0 THEN
				DELETE FROM WRITES WHERE ISBN = ARG_ISBN;
				INSERT INTO WRITES (AUTHOR_ID, ISBN) VALUES(ARG_AUTHOR_ID, ARG_ISBN);
			END IF;

		END IF;
	END;
/
