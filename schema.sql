/* Database schema to keep the structure of entire database. */

     CREATE TABLE animals (
         id INT GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY,
         name VARCHAR(100),
         date_of_birth DATE,
         escape_attempts INT,
         neutered BOOLEAN,
         weight_kg DECIMAL
);
