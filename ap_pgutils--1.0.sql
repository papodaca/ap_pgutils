\echo Use "CREATE EXTENSION ap_pgutils" to load this file. \quit

CREATE OR REPLACE FUNCTION
gethostname() RETURNS TEXT
AS 'MODULE_PATHNAME', 'pg_gethostname'
LANGUAGE C STABLE;

CREATE OR REPLACE FUNCTION
argon2(
  IN password TEXT,
  IN salt TEXT,
  IN iterations INT DEFAULT 3,
  IN log2_mem INT DEFAULT 12,
  IN outlen INT DEFAULT 32,
  IN variant TEXT DEFAULT 'i',
  IN parallelism INT DEFAULT 1
) RETURNS TEXT
AS 'MODULE_PATHNAME', 'pg_argon2'
LANGUAGE C IMMUTABLE STRICT;

CREATE OR REPLACE FUNCTION
argon2_verify(
  IN encoded TEXT,
  IN password TEXT
) RETURNS BOOL
AS 'MODULE_PATHNAME', 'pg_argon2_verify'
LANGUAGE C IMMUTABLE STRICT;

CREATE OR REPLACE FUNCTION
totp_verify(
  IN b32_secret TEXT,
  IN otp INTEGER,
  IN tolerance INTEGER
) RETURNS BOOLEAN
AS 'MODULE_PATHNAME', 'pg_totp_verify'
LANGUAGE C VOLATILE;

CREATE OR REPLACE FUNCTION
b32_encode(
  IN data BYTEA
) RETURNS TEXT
AS 'MODULE_PATHNAME', 'pg_b32_encode'
LANGUAGE C STABLE;
