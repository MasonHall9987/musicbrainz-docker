-- Pipeline performance indexes for the MusicBrainz mirror.
--
-- These indexes are part of the official MusicBrainz schema but are not always
-- present after a fresh mirror restore. Run this script once against the running
-- MB Docker stack to restore them.
--
-- Usage (run from the repo root):
--   docker exec -i $(docker ps --filter name=musicbrainz -q | head -1) \
--     psql -U musicbrainz musicbrainz_db < backend/musicbrainz-docker/pipeline-indexes.sql
--
-- CONCURRENTLY means the index builds without locking the table for reads or
-- writes. The build takes ~1–3 minutes on a 5M-row release table.
-- Indexes are maintained automatically by Postgres on every INSERT/UPDATE/DELETE
-- — no manual rebuilds are ever needed after replication packets arrive.

CREATE INDEX CONCURRENTLY IF NOT EXISTS release_idx_barcode
    ON musicbrainz.release (barcode);
