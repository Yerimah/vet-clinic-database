/* Populate database with sample data. */

INSERT INTO animals (
    name, 
    date_of_birth, 
    escape_attempts, 
    neutered, 
    weight_kg) 
    VALUES (
        'Agumon', 
        '2020-02-03', 
        0, 
        true, 
        10.23);

INSERT INTO animals (
    name, 
    date_of_birth, 
    escape_attempts, 
    neutered, 
    weight_kg) 
    VALUES (
        'Gabumon', 
        '2018-11-15', 
        2, true, 8);

INSERT INTO animals (
    name, 
    date_of_birth, 
    escape_attempts, 
    neutered, 
    weight_kg) 
    VALUES (
        'Pikachu', 
        '2021-01-07', 
        1, 
        false, 
        15.04);

INSERT INTO animals (
    name, 
    date_of_birth, 
    escape_attempts, 
    neutered, 
    weight_kg) 
    VALUES (
        'Devimon', 
        '2017-05-12', 
        5, 
        true, 
        11);

-- Insert new data into table 
INSERT INTO animals (
    name, 
    date_of_birth, 
    escape_attempts, 
    neutered, 
    weight_kg) 
    VALUES (
        'Charmander', 
        '2020-02-08', 
        0, 
        false, 
        -11);

INSERT INTO animals (
    name, 
    date_of_birth, 
    escape_attempts, 
    neutered, 
    weight_kg) 
    VALUES (
        'Plantmon', 
        '2021-11-15', 
        2, 
        true, 
        -5.7);

INSERT INTO animals (
    name, 
    date_of_birth, 
    escape_attempts, 
    neutered, 
    weight_kg) 
    VALUES (
        'Squirtle', 
        '1993-04-02', 
        3, 
        false, 
        -12.13);

INSERT INTO animals (
    name, 
    date_of_birth, 
    escape_attempts, 
    neutered, 
    weight_kg) 
    VALUES (
        'Angemon', 
        '2005-06-12', 
        1, 
        true, 
        -45);

INSERT INTO animals (
    name, 
    date_of_birth, 
    escape_attempts, 
    neutered, 
    weight_kg) 
    VALUES (
        'Boarmon', 
        '2005-06-07', 
        7, 
        true, 
        20.4);

INSERT INTO animals (
    name, 
    date_of_birth, 
    escape_attempts, 
    neutered, 
    weight_kg) 
    VALUES (
        'Blossom', 
        '1998-10-13', 
        3, 
        true, 
        17);

INSERT INTO animals (
    name, 
    date_of_birth, 
    escape_attempts, 
    neutered, 
    weight_kg) 
    VALUES (
        'Ditto', 
        '2022-05-14', 
        4, 
        true, 
        22);

-- setting the species column to unspecified
BEGIN; -- start transaction

UPDATE animals SET species = 'unspecified';

-- Verify that change was made
SELECT * FROM animals;

-- Then roll back the change
ROLLBACK;

-- verify that species columns went back to the state before transaction.
SELECT * FROM animals;

/* Adding animal species*/

BEGIN; -- start transaction

-- setting the species column to digimon for all animals that have a name ending in mon.
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';

-- setting the species column to pokemon for all animals that don't have species already set.
Update animals SET species = 'pokemon' WHERE species IS NULL;

COMMIT; --Commit the transaction.

-- Verify that change was made and persists after commit.
SELECT * FROM animals;

/* Deleting all animal*/
BEGIN;

DELETE FROM animals;

-- verify that the animals have been deleted
SELECT * FROM animals;

ROLLBACK;

-- very that table content are present
SELECT * FROM animals;

-- savepoint
BEGIN;

DELETE FROM animals WHERE date_of_birth > '2020-01-01';

SAVEPOINT save_point;

UPDATE animals SET weight_kg = weight_kg * -1;

ROLLBACK TO save_point;

UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;

COMMIT;