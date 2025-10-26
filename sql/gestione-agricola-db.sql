-- Creiamo prima il database (chiamato "Schema" in Workbench)
CREATE DATABASE IF NOT EXISTS gestione_agricola;

-- Diciamo a MySQL di usare questo database per i prossimi comandi
USE gestione_agricola;

-- 1. Anagrafica Terreni
CREATE TABLE TERRENO (
    ID_Terreno INT AUTO_INCREMENT PRIMARY KEY,
    Nome_Appezzamento VARCHAR(100) NOT NULL,
    Dimensione_Ettari DECIMAL(8, 2) NOT NULL,
    Tipo_Suolo VARCHAR(50),
    Note_Terreno TEXT
);

-- 2. Anagrafica Tipi di Coltura
CREATE TABLE COLTURA (
    ID_Coltura INT AUTO_INCREMENT PRIMARY KEY,
    Nome_Coltura VARCHAR(100) NOT NULL UNIQUE,
    Varieta VARCHAR(100),
    Ciclo_Giorni_Stimato INT
);

-- 3. Anagrafica Personale
CREATE TABLE PERSONALE (
    ID_Personale INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,ID_CicloData_Fine_Previstaciclo_colturale
    Cognome VARCHAR(100) NOT NULL,
    Ruolo VARCHAR(50)
);

-- 4. Anagrafica Prodotti (Fertilizzanti, Sementi, ecc.)
CREATE TABLE PRODOTTO (
    ID_Prodotto INT AUTO_INCREMENT PRIMARY KEY,
    Nome_Prodotto VARCHAR(150) NOT NULL,
    Tipo_Prodotto ENUM('Fertilizzante', 'Semente', 'Pesticida', 'Altro') NOT NULL,
    Unita_Misura VARCHAR(20) -- es. 'kg', 'litri', 'quintali'
);

-- 5. Anagrafica Macchinari
CREATE TABLE MACCHINARIO (
    ID_Macchinario INT AUTO_INCREMENT PRIMARY KEY,
    Nome_Macchinario VARCHAR(100) NOT NULL, -- es. 'Trattore JD 8R', 'Mietitrebbia NH'
    Tipo_Macchinario VARCHAR(100),
    Data_Acquisto DATE
);

-- 6. Tabella per tracciare cosa cresce dove e quando
CREATE TABLE CICLO_COLTURALE (
    ID_Ciclo INT AUTO_INCREMENT PRIMARY KEY,
    Data_Inizio DATE NOT NULL,
    Data_Fine_Prevista DATE,
    Data_Fine_Effettiva DATE,
    Stato_Ciclo ENUM('Pianificato', 'In Corso', 'Raccolto', 'Fallito') NOT NULL,
    
    -- Chiavi esterne (FK) che collegano il ciclo al terreno e alla coltura
    ID_Terreno_FK INT,
    ID_Coltura_FK INT,
    
    FOREIGN KEY (ID_Terreno_FK) REFERENCES TERRENO(ID_Terreno),
    FOREIGN KEY (ID_Coltura_FK) REFERENCES COLTURA(ID_Coltura)
);

-- 7. Tabella principale: il registro delle Lavorazioni
CREATE TABLE LAVORAZIONE (
    ID_Lavorazione INT AUTO_INCREMENT PRIMARY KEY,
    Data_Lavorazione DATETIME NOT NULL,
    Tipo_Lavorazione VARCHAR(100) NOT NULL, -- es. 'Aratura', 'Semina', 'Concimazione', 'Raccolta'
    Descrizione TEXT,
    
    -- Chiavi esterne (FK) che collegano la lavorazione
    ID_Ciclo_FK INT, -- A quale ciclo colturale si riferisce?
    ID_Personale_FK INT, -- Chi l'ha fatta?
    
    FOREIGN KEY (ID_Ciclo_FK) REFERENCES CICLO_COLTURALE(ID_Ciclo),
    FOREIGN KEY (ID_Personale_FK) REFERENCES PERSONALE(ID_Personale)
);

-- 8. Tabella Ponte: Prodotti usati in una Lavorazione (Relazione N:M)
CREATE TABLE DETTAGLIO_LAVORAZIONE_PRODOTTI (
    ID_Lavorazione_FK INT,
    ID_Prodotto_FK INT,
    Quantita_Usata DECIMAL(10, 2) NOT NULL,
    
    -- Chiave primaria composta
    PRIMARY KEY (ID_Lavorazione_FK, ID_Prodotto_FK),
    
    FOREIGN KEY (ID_Lavorazione_FK) REFERENCES LAVORAZIONE(ID_Lavorazione),
    FOREIGN KEY (ID_Prodotto_FK) REFERENCES PRODOTTO(ID_Prodotto)
);

-- 9. Tabella Ponte: Macchinari usati in una Lavorazione (Relazione N:M)
CREATE TABLE DETTAGLIO_LAVORAZIONE_MACCHINARI (
    ID_Lavorazione_FK INT,
    ID_Macchinario_FK INT,
    Ore_Utilizzo DECIMAL(5, 1),
    
    -- Chiave primaria composta
    PRIMARY KEY (ID_Lavorazione_FK, ID_Macchinario_FK),
    
    FOREIGN KEY (ID_Lavorazione_FK) REFERENCES LAVORAZIONE(ID_Lavorazione),
    FOREIGN KEY (ID_Macchinario_FK) REFERENCES MACCHINARIO(ID_Macchinario)
);