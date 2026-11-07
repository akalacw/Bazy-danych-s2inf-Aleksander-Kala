DROP TABLE IF EXISTS kategorie CASCADE;
DROP TABLE IF EXISTS dania CASCADE;

CREATE TABLE kategorie (
    id          SERIAL PRIMARY KEY,
    nazwa       VARCHAR(50) NOT NULL
);

CREATE TABLE dania (
    id              SERIAL PRIMARY KEY,
    nazwa           VARCHAR(100) NOT NULL,
    kategoria_id    INTEGER REFERENCES kategorie(id),
    cena            NUMERIC(6,2) NOT NULL,
    data_dodania    DATE,
    dostepne        BOOLEAN DEFAULT TRUE
);

INSERT INTO kategorie (nazwa) VALUES
    ('Dania główne'),
    ('Zupy'),
    ('Przystawki'),
    ('Desery'),
    ('Napoje zimne'),
    ('Napoje ciepłe'),
    ('Sałatki'),
    ('Pizza'),
    ('Burger'),
    ('Sushi');

INSERT INTO dania (nazwa, kategoria_id, cena, data_dodania, dostepne) VALUES
    ('Schabowy z ziemniakami', 1, 38.50, '2026-01-15', TRUE),
    ('Rosół z makaronem', 2, 16.00, '2026-01-10', TRUE),
    ('Tatar wołowy', 3, 29.99, '2026-02-01', TRUE),
    ('Sernik wiedeński', 4, 18.50, '2026-02-05', TRUE),
    ('Sok pomarańczowy 0.3l', 5, 10.00, '2026-01-12', TRUE),
    ('Kawa Espresso', 6, 9.00, '2026-01-12', TRUE),
    ('Sałatka Grecka', 7, 26.00, '2026-01-20', TRUE),
    ('Pizza Margherita', 8, 32.00, '2026-01-25', TRUE),
    ('Burger Klasyczny', 9, 34.50, '2026-01-28', TRUE),
    ('Zestaw Hosomaki (8 szt.)', 10, 28.00, '2026-02-03', FALSE);

SELECT * FROM kategorie;
SELECT * FROM dania;