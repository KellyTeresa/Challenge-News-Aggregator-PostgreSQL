-- If you want to run this schema repeatedly you'll need to drop
-- the table before re-creating it. Note that you'll lose any
-- data if you drop and add a table:

-- DROP TABLE IF EXISTS articles;

-- Define your schema here:

CREATE TABLE articles (
  title VARCHAR(255) NOT NULL,
  url VARCHAR(2047) NOT NULL UNIQUE,
  description VARCHAR(2047) NOT NULL
);


-- The below is not needed since 'url' is already defined as UNIQUE above.
-- Leaving in for reference.

-- CREATE UNIQUE INDEX url_id ON articles (url);
