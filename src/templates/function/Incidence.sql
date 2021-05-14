CREATE OR REPLACE FUNCTION insert_incidence() RETURNS TRIGGER AS
$$
BEGIN
    IF NOT EXISTS(SELECT *
                  FROM Incidence
                    WHERE NumDep = NEW.NumDep
                    AND jour = NEW.Jour) THEN
        RETURN NEW;
    END IF;
    RETURN NULL;
END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION audit_incid_dc_fun() RETURNS TRIGGER AS $$
DECLARE
  nb INTEGER;
BEGIN
  nb:= NEW.incidDc - OLD.incidDc;
  CASE

  WHEN TG_OP='INSERT' THEN
    IF nb <> 0 THEN -- on ignore (pas de trace pour) les insertions où incidDc = 0
      INSERT INTO audit_incid_dc_tab(numDep, date_dc, description, nombre)
      VALUES (NEW.numDep, CURRENT_DATE, 'NOUVEAUX DC', NEW.incidDc);
    END IF;

  WHEN TG_OP='DELETE' THEN
  IF nb <> 0 THEN -- on ignore (pas de trace pour) les suppression où incidDc = 0
    INSERT INTO audit_incid_dc_tab(numDep, date_dc, description, nombre)
    VALUES (OLD.numDep, CURRENT_DATE, 'SUPPRESSION', OLD.incidDc);
  END IF;

  WHEN TG_OP= 'UPDATE' THEN

    IF nb <> 0 THEN -- on ignore les màj de incidDc = 0
      INSERT INTO audit_incid_dc_tab(numDep, date_dc, description, nombre)
      VALUES (OLD.numDep, OLD.date_dc,
              CASE WHEN nb >= 0
                   THEN 'MAJ + DC' -- de nouveau décès ce jour là dans ce départementlà
                   ELSE 'MAJ - DC' -- finalement, il y a moins de décès que ce qui a été déclarés auparavant
              END,
              nb);
    END IF;
  END CASE;
  RETURN NEW; -- ignoré car trigger `AFTER`
END;
$$ LANGUAGE plpgsql;
