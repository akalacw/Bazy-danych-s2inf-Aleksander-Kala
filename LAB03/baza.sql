DROP TABLE IF EXISTS zamowienia CASCADE;
DROP TABLE IF EXISTS pracownicy CASCADE;
DROP TABLE IF EXISTS klienci CASCADE;
DROP TABLE IF EXISTS produkty CASCADE;
DROP TABLE IF EXISTS kategorie CASCADE;

CREATE TABLE kategorie (
    id          SERIAL PRIMARY KEY,
    nazwa       VARCHAR(100),
    opis        TEXT
);

CREATE TABLE produkty (
    id              SERIAL PRIMARY KEY,
    nazwa           VARCHAR(150),
    kategoria_id    INTEGER REFERENCES kategorie(id),
    cena            NUMERIC(10,2),
    ilosc_magazyn   INTEGER,
    data_dodania    DATE
);

CREATE TABLE klienci (
    id                  SERIAL PRIMARY KEY,
    imie                VARCHAR(50),
    nazwisko            VARCHAR(50),
    email               VARCHAR(100),
    data_rejestracji    DATE,
    miasto              VARCHAR(50)
);

CREATE TABLE pracownicy (
    id                  SERIAL PRIMARY KEY,
    imie                VARCHAR(50),
    nazwisko            VARCHAR(50),
    stanowisko          VARCHAR(50),
    data_zatrudnienia   DATE
);

CREATE TABLE zamowienia (
    id                  SERIAL PRIMARY KEY,
    klient_id           INTEGER REFERENCES klienci(id),
    pracownik_id        INTEGER REFERENCES pracownicy(id),
    data_zamowienia     DATE,
    status              VARCHAR(30)
);

INSERT INTO kategorie (nazwa, opis) VALUES 
    ('Elektronika', 'Sprzęt elektroniczny'), 
    ('Ksiazki', 'Literatura piękna i naukowa');

INSERT INTO produkty (nazwa, kategoria_id, cena, ilosc_magazyn, data_dodania) VALUES
    ('Laptop Pro 15', 1, 3500.00, 4, CURRENT_DATE - INTERVAL '10 days'),
    ('Mysz bezprzewodowa', 1, 95.50, 25, CURRENT_DATE - INTERVAL '5 days'),
    ('Klawiatura mechaniczna', 1, 220.00, 3, CURRENT_DATE - INTERVAL '60 days'),
    ('Monitor 27 cali', 1, 1100.00, 2, CURRENT_DATE - INTERVAL '120 days'),
    ('Pendrive 64GB', 1, 45.00, 150, CURRENT_DATE - INTERVAL '2 days'),
    ('Pioro wieczne', 2, 105.00, 12, CURRENT_DATE - INTERVAL '15 days'),
    ('Zestaw pisakow', 2, 25.00, 8, CURRENT_DATE - INTERVAL '400 days');

INSERT INTO klienci (imie, nazwisko, email, data_rejestracji, miasto) VALUES
    ('Jan', 'Kowalski', 'jan.kowalski@example.com', CURRENT_DATE - INTERVAL '200 days', 'Wroclaw'),
    ('Anna', 'Nowak', 'anna.nowak@example.com', CURRENT_DATE - INTERVAL '600 days', 'Poznan'),
    ('Piotr', 'Wisniewski', 'piotr.w@example.com', CURRENT_DATE - INTERVAL '100 days', 'Warszawa'),
    ('Katarzyna', 'Adamska', 'k.adamska@example.com', CURRENT_DATE - INTERVAL '50 days', 'Wroclaw');

INSERT INTO pracownicy (imie, nazwisko, stanowisko, data_zatrudnienia) VALUES
    ('Tomasz', 'Maj', 'Sprzedawca', '2023-01-15'),
    ('Magdalena', 'Kaczmarek', 'Kierownik', '2021-05-10');

INSERT INTO zamowienia (klient_id, pracownik_id, data_zamowienia, status) VALUES
    (1, 1, CURRENT_DATE - INTERVAL '2 days', 'zrealizowane'),
    (2, 1, CURRENT_DATE - INTERVAL '5 days', 'anulowane'),
    (3, 2, CURRENT_DATE - INTERVAL '1 day', 'nowe'),
    (4, 2, CURRENT_DATE - INTERVAL '10 days', 'anulowane');

-- 1. 
SELECT nazwa, cena 
FROM produkty 
WHERE cena > 200 
ORDER BY cena DESC;

-- 2. 
SELECT imie, nazwisko, miasto 
FROM klienci 
WHERE miasto IN ('Wroclaw', 'Poznan');

-- 3. 
SELECT nazwa, cena 
FROM produkty 
ORDER BY cena ASC 
LIMIT 10;

-- 4. 
SELECT * 
FROM zamowienia 
WHERE status = 'anulowane' 
ORDER BY data_zamowienia DESC;

-- 5. 
SELECT * 
FROM produkty 
WHERE nazwa LIKE 'P%';

-- 6. 
SELECT * 
FROM produkty 
WHERE ilosc_magazyn < 5;

-- 7. 
SELECT * 
FROM klienci 
WHERE data_rejestracji > CURRENT_DATE - INTERVAL '500 days';

-- 8. 
(SELECT nazwa, cena, 'Najdroższy' AS kategoria_cenowa FROM produkty ORDER BY cena DESC LIMIT 5)
UNION ALL
(SELECT nazwa, cena, 'Najtańszy' AS kategoria_cenowa FROM produkty ORDER BY cena ASC LIMIT 5);

-- 9. 
SELECT * 
FROM produkty 
WHERE data_dodania >= CURRENT_DATE - INTERVAL '30 days';

-- 10. 
SELECT DISTINCT miasto 
FROM klienci;

-- 11. 
SELECT nazwisko, UPPER(nazwisko) AS nazwisko_wielkie 
FROM klienci;

-- 12. 
SELECT * 
FROM produkty 
WHERE ROUND(cena) BETWEEN 90 AND 110;

-- 13. 
SELECT * 
FROM klienci 
WHERE nazwisko LIKE '%ski' OR imie LIKE 'A%';

-- 14. 
SELECT * 
FROM zamowienia 
ORDER BY data_zamowienia ASC 
LIMIT 5;

-- 15. 
SELECT * 
FROM produkty 
WHERE cena NOT BETWEEN 100 AND 300;

-- 16. 
SELECT nazwa, (CURRENT_DATE - data_dodania) AS dni_od_dodania 
FROM produkty 
ORDER BY dni_od_dodania DESC;