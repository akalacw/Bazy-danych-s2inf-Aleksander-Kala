DROP TABLE IF EXISTS pozycje_zamowien CASCADE;
DROP TABLE IF EXISTS zamowienia CASCADE;
DROP TABLE IF EXISTS produkty CASCADE;
DROP TABLE IF EXISTS kategorie CASCADE;
DROP TABLE IF EXISTS klienci CASCADE;
DROP TABLE IF EXISTS pracownicy CASCADE;

CREATE TABLE kategorie (
    id          SERIAL PRIMARY KEY,
    nazwa       VARCHAR(100) NOT NULL,
    opis        TEXT
);

CREATE TABLE produkty (
    id              SERIAL PRIMARY KEY,
    nazwa           VARCHAR(150) NOT NULL,
    kategoria_id    INTEGER REFERENCES kategorie(id),
    cena            NUMERIC(10,2) NOT NULL,
    ilosc_magazyn   INTEGER DEFAULT 0,
    data_dodania    DATE DEFAULT CURRENT_DATE
);

CREATE TABLE klienci (
    id                  SERIAL PRIMARY KEY,
    imie                VARCHAR(50) NOT NULL,
    nazwisko            VARCHAR(50) NOT NULL,
    email               VARCHAR(100) UNIQUE,
    data_rejestracji    DATE DEFAULT CURRENT_DATE,
    miasto              VARCHAR(50)
);

CREATE TABLE pracownicy (
    id                  SERIAL PRIMARY KEY,
    imie                VARCHAR(50) NOT NULL,
    nazwisko            VARCHAR(50) NOT NULL,
    stanowisko          VARCHAR(50),
    data_zatrudnienia   DATE DEFAULT CURRENT_DATE
);

CREATE TABLE zamowienia (
    id                  SERIAL PRIMARY KEY,
    klient_id           INTEGER REFERENCES klienci(id),
    pracownik_id        INTEGER REFERENCES pracownicy(id),
    data_zamowienia     DATE DEFAULT CURRENT_DATE,
    status              VARCHAR(30) DEFAULT 'nowe'
);

CREATE TABLE pozycje_zamowien (
    id                  SERIAL PRIMARY KEY,
    zamowienie_id       INTEGER REFERENCES zamowienia(id),
    produkt_id          INTEGER REFERENCES produkty(id),
    ilosc               INTEGER NOT NULL,
    cena_jednostkowa    NUMERIC(10,2) NOT NULL
);

INSERT INTO kategorie (nazwa, opis) VALUES
    ('Elektronika', 'Sprzęt elektroniczny'),
    ('Ksiazki', 'Literatura i komiksy'),
    ('AGD', 'Sprzęt gospodarstwa domowego'),
    ('Biuro', 'Artykuły biurowe');

INSERT INTO produkty (nazwa, kategoria_id, cena, ilosc_magazyn, data_dodania) VALUES
    ('Laptop Ultra', 1, 4500.00, 10, CURRENT_DATE - INTERVAL '100 days'),
    ('Smartphone X', 1, 2800.00, 15, CURRENT_DATE - INTERVAL '90 days'),
    ('Sluchawki BT', 1, 250.00, 30, CURRENT_DATE - INTERVAL '80 days'),
    ('Monitor 4K', 1, 1400.00, 5, CURRENT_DATE - INTERVAL '70 days'),
    ('Klawiatura Mechaniczna', 1, 350.00, 20, CURRENT_DATE - INTERVAL '60 days'),
    ('Mysz Ergonomiczna', 1, 180.00, 25, CURRENT_DATE - INTERVAL '50 days'),
    ('Kabel USB-C', 1, 45.00, 50, CURRENT_DATE - INTERVAL '40 days'),
    ('Podręcznik SQL', 2, 85.00, 100, CURRENT_DATE - INTERVAL '30 days'),
    ('Czajnik Elektryczny', 3, 120.00, 12, CURRENT_DATE - INTERVAL '20 days'),
    ('Niszczarka Dokumentów', 4, 310.00, 3, CURRENT_DATE - INTERVAL '10 days'), -- Produkt nigdy niezamówiony (Zadanie 5)
    ('Kalkulator Naukowy', 4, 95.00, 8, CURRENT_DATE - INTERVAL '5 days');

INSERT INTO klienci (imie, nazwisko, email, data_rejestracji, miasto) VALUES
    ('Jan', 'Kowalski', 'jan.k@example.com', '2024-01-10', 'Wroclaw'),
    ('Anna', 'Nowak', 'anna.n@example.com', '2024-02-15', 'Poznan'),
    ('Piotr', 'Wisniewski', 'piotr.w@example.com', '2024-03-20', 'Warszawa'),
    ('Katarzyna', 'Wojcik', 'katarzyna.w@example.com', '2024-04-05', 'Wroclaw'),
    ('Marek', 'Zajac', 'marek.z@example.com', '2024-05-12', 'Krakow'); 

INSERT INTO pracownicy (imie, nazwisko, stanowisko, data_zatrudnienia) VALUES
    ('Tomasz', 'Adamiak', 'Specjalista ds. Sprzedaży', '2023-01-15'),
    ('Ewa', 'Kaczmarek', 'Doradca Klienta', '2023-06-01'),
    ('Michal', 'Lisiecki', 'Młodszy Konsultant', '2024-01-01'); 

INSERT INTO zamowienia (klient_id, pracownik_id, data_zamowienia, status) VALUES
    (1, 1, CURRENT_DATE - INTERVAL '15 days', 'zrealizowane'),
    (1, 1, CURRENT_DATE - INTERVAL '10 days', 'zrealizowane'),
    (2, 1, CURRENT_DATE - INTERVAL '8 days', 'w trakcie'),
    (3, 2, CURRENT_DATE - INTERVAL '5 days', 'zrealizowane'),
    (4, 2, CURRENT_DATE - INTERVAL '2 days', 'anulowane');

INSERT INTO pozycje_zamowien (zamowienie_id, produkt_id, ilosc, cena_jednostkowa) VALUES
    (1, 1, 1, 4500.00),
    (1, 3, 2, 250.00),
    (2, 2, 1, 2800.00),
    (3, 8, 3, 85.00),
    (4, 4, 2, 1400.00),
    (4, 5, 1, 350.00),
    (5, 6, 1, 180.00);

-- 1. 
SELECT z.id AS zamowienie_id, z.data_zamowienia, z.status, k.imie, k.nazwisko
FROM zamowienia z
JOIN klienci k ON z.klient_id = k.id;

-- 2. 
SELECT kat.nazwa AS kategoria, ROUND(AVG(p.cena), 2) AS srednia_cena
FROM kategorie kat
LEFT JOIN produkty p ON kat.id = p.kategoria_id
GROUP BY kat.id, kat.nazwa;

-- 3. 
SELECT k.id, k.imie, k.nazwisko, SUM(pz.ilosc * pz.cena_jednostkowa) AS suma_wydatkow
FROM klienci k
JOIN zamowienia z ON k.id = z.klient_id
JOIN pozycje_zamowien pz ON z.id = pz.zamowienie_id
GROUP BY k.id, k.imie, k.nazwisko
ORDER BY suma_wydatkow DESC
LIMIT 5;

-- 4. 
SELECT kat.nazwa AS kategoria, COUNT(p.id) AS liczba_produktow
FROM kategorie kat
JOIN produkty p ON kat.id = p.kategoria_id
GROUP BY kat.id, kat.nazwa
HAVING COUNT(p.id) > 5;

-- 5. 
SELECT p.id, p.nazwa, p.cena
FROM produkty p
LEFT JOIN pozycje_zamowien pz ON p.id = pz.produkt_id
WHERE pz.id IS NULL;

-- 6. 
SELECT status, COUNT(*) AS liczba_zamowien
FROM zamowienia
GROUP BY status;

-- 7. 
SELECT pr.id, pr.imie, pr.nazwisko, COUNT(z.id) AS liczba_zamowien
FROM pracownicy pr
JOIN zamowienia z ON pr.id = z.pracownik_id
GROUP BY pr.id, pr.imie, pr.nazwisko
ORDER BY liczba_zamowien DESC
LIMIT 1;

-- 8. 
SELECT k.id, k.imie, k.nazwisko, COUNT(z.id) AS liczba_zamowien
FROM klienci k
LEFT JOIN zamowienia z ON k.id = z.klient_id
GROUP BY k.id, k.imie, k.nazwisko
ORDER BY liczba_zamowien DESC;

-- 9. 
SELECT kat.nazwa AS kategoria, COALESCE(SUM(pz.ilosc * pz.cena_jednostkowa), 0) AS wartosc_sprzedazy
FROM kategorie kat
JOIN produkty p ON kat.id = p.kategoria_id
JOIN pozycje_zamowien pz ON p.id = pz.produkt_id
GROUP BY kat.id, kat.nazwa
ORDER BY wartosc_sprzedazy DESC
LIMIT 5;

-- 10. 
SELECT p1.id, p1.nazwa, p1.kategoria_id, p1.cena
FROM produkty p1
WHERE p1.cena > (
    SELECT AVG(p2.cena) 
    FROM produkty p2 
    WHERE p2.kategoria_id = p1.kategoria_id
);

-- 11. 
SELECT k.id, k.imie, k.nazwisko, k.email
FROM klienci k
LEFT JOIN zamowienia z ON k.id = z.klient_id
WHERE z.id IS NULL;

-- 12. 
SELECT kat.nazwa AS kategoria, COALESCE(SUM(pz.ilosc), 0) AS lacznie_sprzedanych_sztuk
FROM kategorie kat
JOIN produkty p ON kat.id = p.kategoria_id
JOIN pozycje_zamowien pz ON p.id = pz.produkt_id
GROUP BY kat.id, kat.nazwa
ORDER BY lacznie_sprzedanych_sztuk DESC;

-- 13. 
SELECT pr.id, pr.imie, pr.nazwisko, COUNT(z.id) AS liczba_zamowien
FROM pracownicy pr
LEFT JOIN zamowienia z ON pr.id = z.pracownik_id
GROUP BY pr.id, pr.imie, pr.nazwisko
HAVING COUNT(z.id) < (
    SELECT COUNT(id)::NUMERIC / (SELECT COUNT(*) FROM pracownicy) 
    FROM zamowienia
)
ORDER BY liczba_zamowien ASC;

-- 14. 
SELECT p.id, p.nazwa, COUNT(pz.id) AS liczba_wystapien
FROM produkty p
JOIN pozycje_zamowien pz ON p.id = pz.produkt_id
GROUP BY p.id, p.nazwa
ORDER BY liczba_wystapien DESC
LIMIT 3;