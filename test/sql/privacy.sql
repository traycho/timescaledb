-- This file and its contents are licensed under the Apache License 2.0.
-- Please see the included NOTICE for copyright information and
-- LICENSE-APACHE for a copy of the license.

\c :TEST_DBNAME :ROLE_SUPERUSER
CREATE OR REPLACE FUNCTION _timescaledb_internal.test_privacy() RETURNS BOOLEAN
    AS :MODULE_PATHNAME, 'ts_test_privacy' LANGUAGE C IMMUTABLE STRICT PARALLEL SAFE;
\c :TEST_DBNAME :ROLE_DEFAULT_PERM_USER

SET timescaledb.telemetry_level=off;
SELECT 'Executed' AS test_privacy FROM _timescaledb_internal.test_privacy();

RESET timescaledb.telemetry_level;
SELECT 'Executed' AS test_privacy FROM _timescaledb_internal.test_privacy();

-- To make sure nothing was sent, we check the UUID table to make sure no exported UUID row was created
SELECT key from _timescaledb_catalog.metadata;
