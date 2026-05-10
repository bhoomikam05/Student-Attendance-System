-- Create Database
CREATE DATABASE IF NOT EXISTS studentdb;

USE studentdb;

-- Drop and recreate students table with all fields
CREATE TABLE IF NOT EXISTS students (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(100) NOT NULL,
    first_name  VARCHAR(60)  NOT NULL DEFAULT '',
    last_name   VARCHAR(60)  NOT NULL DEFAULT '',
    email       VARCHAR(100) NOT NULL UNIQUE,
    roll_no     VARCHAR(30)  NOT NULL DEFAULT '',
    usn         VARCHAR(30)  NOT NULL DEFAULT '',
    course      VARCHAR(100) NOT NULL,
    year        VARCHAR(20)  NOT NULL DEFAULT '',
    section     VARCHAR(10)  NOT NULL DEFAULT '',
    phone       VARCHAR(15)  NOT NULL DEFAULT '',
    password    VARCHAR(255) NOT NULL DEFAULT 'student123',
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ALTER existing table (run if table already exists instead of CREATE)
-- ALTER TABLE students ADD COLUMN IF NOT EXISTS first_name VARCHAR(60) NOT NULL DEFAULT '';
-- ALTER TABLE students ADD COLUMN IF NOT EXISTS last_name  VARCHAR(60) NOT NULL DEFAULT '';
-- ALTER TABLE students ADD COLUMN IF NOT EXISTS roll_no    VARCHAR(30) NOT NULL DEFAULT '';
-- ALTER TABLE students ADD COLUMN IF NOT EXISTS usn        VARCHAR(30) NOT NULL DEFAULT '';
-- ALTER TABLE students ADD COLUMN IF NOT EXISTS year       VARCHAR(20) NOT NULL DEFAULT '';
-- ALTER TABLE students ADD COLUMN IF NOT EXISTS section    VARCHAR(10) NOT NULL DEFAULT '';
-- ALTER TABLE students ADD COLUMN IF NOT EXISTS phone      VARCHAR(15) NOT NULL DEFAULT '';
-- ALTER TABLE students ADD COLUMN IF NOT EXISTS password   VARCHAR(255) NOT NULL DEFAULT 'student123';
-- ALTER TABLE students ADD COLUMN IF NOT EXISTS created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP;