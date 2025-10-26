# gestione-agricola-db
Progetto personale per apprendimento di Mysql con riferimento ad una gestione agricola di terreni generici. Progetto creato a Gennaio 2025.

Questo progetto contiene lo schema e i dati di esempio per un database relazionale (MySQL) progettato per la gestione di terreni agricoli, colture e attività agricole.

L'obiettivo è tracciare le lavorazioni, l'uso di prodotti, l'impiego di macchinari e i cicli colturali per ottimizzare la gestione di un'azienda agricola.

Il progetto è stato sviluppato partendo da una metodologia di progettazione standard ed implementato in SQL per MySQL.

## Schema del Database

Il database è composto dalle seguenti tabelle principali:

* **ANAGRAFICHE**
    * `TERRENO`: Elenco degli appezzamenti di terreno.
    * `COLTURA`: Anagrafica delle possibili colture (es. Grano, Mais).
    * `PERSONALE`: Elenco degli operatori.
    * `PRODOTTO`: Anagrafica dei prodotti (fertilizzanti, sementi, ecc.).
    * `MACCHINARIO`: Anagrafica dei mezzi agricoli.

* **OPERATIVE**
    * `CICLO_COLTURALE`: Traccia quale coltura è piantata in quale terreno in un dato periodo.
    * `LAVORAZIONE`: Il registro centrale di tutte le attività (es. Aratura, Semina, Raccolta), collegate al personale e al ciclo colturale.
    * `DETTAGLIO_LAVORAZIONE_PRODOTTI`: Tabella ponte che collega le lavorazioni ai prodotti usati e alle quantità.
    * `DETTAGLIO_LAVORAZIONE_MACCHINARI`: Tabella ponte che collega le lavorazioni ai macchinari impiegati e alle ore di utilizzo.

## Esempio di Query

Per ottenere un report di tutte le lavorazioni (e chi le ha fatte) avvenute sul terreno "Campo Nord":

USE gestione_agricola;

SELECT
    t.Nome_Appezzamento,
    l.Data_Lavorazione,
    l.Tipo_Lavorazione,
    p.Nome,
    p.Cognome AS Operatore
FROM LAVORAZIONE l
JOIN CICLO_COLTURALE cc ON l.ID_Ciclo_FK = cc.ID_Ciclo
JOIN TERRENO t ON cc.ID_Terreno_FK = t.ID_Terreno
JOIN PERSONALE p ON l.ID_Personale_FK = p.ID_Personale
WHERE t.Nome_Appezzamento = 'Campo Nord'
ORDER BY l.Data_Lavorazione;