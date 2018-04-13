CREATE TABLE magazin (
  id        INT UNIQUE,
  product VARCHAR(50),
  cena VARCHAR(10)
);

INSERT INTO magazin (id, product,cena) VALUES (1, 'Чай', 15.45);
DROP TABLE journal_history;

CREATE TABLE journal_history (
  id           SERIAL,
  temp_id      INT         NOT NULL,
  temp_product    VARCHAR(50) NOT NULL,
  temp_cena    VARCHAR(10) NOT NULL,
  name_of_oper VARCHAR(15),
  time_action  TIMESTAMP WITHOUT TIME ZONE,
  deleted      BOOLEAN
);


CREATE OR REPLACE FUNCTION func_tr()
  RETURNS TRIGGER AS
$$
DECLARE
BEGIN
  IF (tg_op = 'INSERT')
  THEN
    INSERT INTO journal_history (id, temp_id, temp_product, temp_cena, name_of_oper, time_action, deleted)
    VALUES (DEFAULT, new.id, new.product, new.cena, 'insert', clock_timestamp(), FALSE);
  ELSEIF (tg_op = 'UPDATE')
    THEN
      INSERT INTO journal_history (id, temp_id, temp_product, temp_cena, name_of_oper, time_action, deleted)
      VALUES (DEFAULT, new.id, new.product, new.cena, 'update', clock_timestamp(), FALSE);
  ELSEIF (tg_op = 'DELETE')
    THEN
      INSERT INTO journal_history (id, temp_id, temp_product, temp_cena, name_of_oper, time_action, deleted)
      VALUES (DEFAULT, old.id, old.product, old.cena, 'delete', clock_timestamp(), FALSE);
  END IF;
  RETURN NULL;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER tr_ins
  AFTER INSERT OR UPDATE OR DELETE
  ON magazin
  FOR EACH ROW
EXECUTE PROCEDURE func_tr();

DROP FUNCTION func_tr() CASCADE;

DELETE FROM journal_history;
-------------------------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION func_back_time(b_time TIMESTAMP WITHOUT TIME ZONE)
  RETURNS INTEGER AS
$$
DECLARE
    curs CURSOR FOR SELECT *
                    FROM journal_history
                    WHERE time_action > b_time AND deleted = FALSE;
BEGIN
  ALTER TABLE magazin
    DISABLE TRIGGER tr_ins;
  FOR c IN curs
  LOOP
    IF (c.name_of_oper = 'insert') AND (c.deleted = FALSE)
    THEN
      DELETE FROM magazin
      WHERE c.temp_id = id;
      UPDATE journal_history
      SET deleted = TRUE
      WHERE id = c.id;
    ELSEIF (c.name_of_oper = 'update') AND (c.deleted = FALSE)
      THEN
        UPDATE magazin
        SET id = c.temp_id, product = c.temp_product, cena = c.temp_cena
        WHERE id = c.temp_id;
        UPDATE journal_history
        SET deleted = TRUE
        WHERE id = c.id;
    ELSEIF (c.name_of_oper = 'delete') AND (c.deleted = FALSE)
      THEN
        INSERT INTO magazin (id, product, cena) VALUES (c.temp_id, c.temp_product, c.temp_cena);
        UPDATE journal_history
        SET deleted = TRUE
        WHERE id = c.id;
    END IF;
  END LOOP;
  ALTER TABLE magazin
    ENABLE TRIGGER tr_ins;
  RETURN 0;
END;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION func_back_num(num_operation INTEGER)
  RETURNS INTEGER
AS $$
DECLARE
    num_cur CURSOR FOR SELECT *
                       FROM journal_history
                       WHERE deleted <> TRUE
                       ORDER BY time_action DESC
                       LIMIT num_operation;

BEGIN
  ALTER TABLE magazin
    DISABLE TRIGGER tr_ins;
  FOR num IN num_cur
  LOOP
    IF (num.name_of_oper = 'insert') AND (num.deleted = FALSE)
    THEN
      DELETE FROM magazin
      WHERE id = num.temp_id;
      UPDATE journal_history
      SET deleted = TRUE
      WHERE id = num.id;
    ELSIF (num.name_of_oper = 'update') AND (num.deleted = FALSE)
      THEN
        UPDATE magazin
        SET id = num.temp_id, product = num.temp_product, cena = num.temp_cena
        WHERE id = num.temp_id;
        UPDATE journal_history
        SET deleted = TRUE
        WHERE id = num.id;
    ELSIF (num.name_of_oper = 'delete') AND (num.deleted = FALSE)
      THEN
        INSERT INTO magazin VALUES (num.temp_id, num.temp_product, num.temp_cena);
        UPDATE journal_history
        SET deleted = TRUE
        WHERE id = num.id;
    END IF;
  END LOOP;

  ALTER TABLE magazin
    ENABLE TRIGGER tr_ins;
  RETURN 0;
END;
$$
LANGUAGE plpgsql;

DELETE FROM magazin;
DELETE FROM journal_history;
SELECT *
FROM journal_history
WHERE deleted = TRUE
ORDER BY time_action ASC
LIMIT 3;
SELECT func_back_num(1);
UPDATE journal_history
SET deleted = TRUE
WHERE temp_id = 1;

CREATE OR REPLACE FUNCTION func_return(num_operation INTEGER)
  RETURNS INTEGER
AS $$
DECLARE
    num_cur CURSOR FOR SELECT *
                       FROM journal_history
                       WHERE deleted = TRUE
                       ORDER BY time_action ASC
                       LIMIT num_operation;

BEGIN
  ALTER TABLE magazin
    DISABLE TRIGGER tr_ins;
  FOR num IN num_cur
  LOOP
    IF (num.name_of_oper = 'insert') AND (num.deleted = TRUE)
    THEN
      INSERT INTO magazin VALUES (num.temp_id, num.temp_product, num.temp_cena);
      UPDATE journal_history
      SET deleted = FALSE
      WHERE id = num.id;
    ELSIF (num.name_of_oper = 'update') AND (num.deleted = TRUE)
      THEN
        UPDATE magazin
        SET id = num.temp_id, product = num.temp_product
        WHERE id = num.temp_id;
        UPDATE journal_history
        SET deleted = FALSE
        WHERE id = num.id;
    ELSIF (num.name_of_oper = 'delete') AND (num.deleted = TRUE)
      THEN
        DELETE FROM magazin
        WHERE id = num.temp_id;
        UPDATE journal_history
        SET deleted = FALSE
        WHERE id = num.id;
    END IF;
  END LOOP;

  ALTER TABLE magazin
    ENABLE TRIGGER tr_ins;
  RETURN 0;
END;
$$
LANGUAGE plpgsql;

INSERT INTO magazin (id, product, cena) VALUES (1,'Чай',50);
INSERT INTO magazin (id, product, cena) VALUES (2,'Кофе',100);
INSERT INTO magazin (id, product, cena) VALUES (3,'Печенье',75);
INSERT INTO magazin (id, product, cena) VALUES (4,'Торт',200);
INSERT INTO magazin (id, product, cena) VALUES (5,'Конфеты',150);

