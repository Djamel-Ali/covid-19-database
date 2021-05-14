-- Mise en place d’une table audit_incid_dc (sur la table incidence)
CREATE TABLE audit_incid_dc_tab (
id_audit_dc SERIAL PRIMARY KEY,
numDep CHAR(3) NOT NULL REFERENCES Departement(numDep),
date_dc DATE NOT NULL,
description VARCHAR(13) NOT NULL
CHECK (description IN ('NOUVEAUX DC', 'MAJ + DC', 'MAJ - DC','SUPPRESSION')),
nombre INTEGER NOT NULL CHECK (nombre > 0)
);
