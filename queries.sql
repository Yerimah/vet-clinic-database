/*Queries that provide answers to the questions from all projects.*/

-- Find all animals whose name ends in "mon"
SELECT * from animals WHERE name LIKE '%mon';

-- List the name of all animals born between 2016 and 2019.
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

-- List the name of all animals that are neutered and have less than 3 escape attempts.
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;

-- List date of birth of all animals named either "Agumon" or "Pikachu".
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';

-- List name and escape attempts of animals that weigh more than 10.5kg
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

-- Find all animals that are neutered.
SELECT * FROM animals WHERE neutered = true;

-- Find all animals not named Gabumon.
SELECT * FROM animals WHERE name != 'Gabumon';

-- Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

-- How many animals are there?
SELECT COUNT(*) FROM animals;

-- How many animals have never tried to escape?
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

-- What is the average weight of animals?
SELECT AVG(weight_kg) FROM animals;

-- Who escapes the most, neutered or not neutered animals?
SELECT neutered, SUM(escape_attempts) FROM animals GROUP BY neutered;

-- What is the minimum and maximum weight of each type of animal?
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth 
BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;

/*Write queries (using JOIN) to answer the following questions*/

-- What animals belong to Melody Pond?
SELECT * FROM animals a INNER JOIN owners o ON a.owner_id = o.id WHERE o.full_name = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon)
SELECT * FROM animals a INNER JOIN species s ON a.species_id = s.id WHERE s.name = 'Pokemon';

-- List all owners and their animals, remember to include those that don't own any animal.
SELECT * FROM owners o FULL OUTER JOIN animals a ON o.id = a.owner_id;

-- How many animals are there per species?
SELECT s.name, COUNT(*) FROM species s LEFT JOIN animals a ON s.id =  a.species_id GROUP BY s.name;

-- List all Digimon owned by Jennifer Orwell.
SELECT * FROM animals a INNER JOIN owners o ON a.owner_id = o.id WHERE o.full_name = 'Jennifer Orwell' 
  AND a.species_id = (SELECT id from species WHERE name = 'Digimon');

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT * FROM animals a INNER JOIN owners o ON a.owner_id = o.id WHERE o.full_name = 'Dean Winchester' 
AND a.escape_attempts <= 0;

-- Who owns the most animals?
SELECT o.full_name, COUNT(*) FROM owners o LEFT JOIN animals a ON o.id =  a.owner_id GROUP BY o.full_name
ORDER BY COUNT DESC LIMIT 1;

-- visits queries
-- Who was the last animal seen by William Tatcher?
SELECT v.name AS vet_name, a.name AS animal_name, vs.date_of_visit
  FROM visits vs INNER JOIN animals a ON a.id = vs.animal_id
  INNER JOIN vets v ON v.id = vs.vets_id
  WHERE v.name = 'William Tatcher'
  ORDER BY vs.date_of_visit DESC
  LIMIT 1;

-- How many different animals did Stephanie Mendez see?
SELECT v.name as vet_name, COUNT(date_of_visit) 
  FROM visits vs LEFT JOIN vets v ON vs.vets_id = v.id
  WHERE name = 'Stephanie Mendez'
  GROUP BY v.name;

-- List all vets and their specialties, including vets with no specialties.
SELECT 
  sp.id AS specialty_id, 
  sp.species_id, 
  sp.vets_id, 
  v.name AS vet_name, 
  s.name AS species_name  
  FROM specializations sp FULL OUTER JOIN species s ON s.id = sp.species_id
  FULL OUTER JOIN vets v 
    ON v.id = sp.vets_id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT 
  a.name, 
  v.name AS vet_name, 
  vs.date_of_visit
  FROM visits vs LEFT JOIN animals a ON a.id = vs.animal_id
  LEFT JOIN vets v 
    ON v.id = vs.vets_id
  WHERE 
    v.name = 'Stephanie Mendez' AND 
    vs.date_of_visit 
    BETWEEN '2020-04-01' AND '2020-08-30';

-- What animal has the most visits to vets?
SELECT a.name, COUNT(*) 
  FROM visits vs INNER JOIN animals a ON a.id = vs.animal_id
  GROUP BY a.name
  ORDER BY COUNT DESC
  LIMIT 1;

-- Who was Maisy Smith's first visit?
SELECT 
  a.name AS animal_name, 
  v.name AS vet_name,
  vs.date_of_visit
  FROM visits vs LEFT JOIN animals a ON a.id = vs.animal_id
  LEFT JOIN vets v ON v.id = vs.vets_id
  WHERE v.name = 'Maisy Smith'
  ORDER BY vs.date_of_visit ASC
  LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT 
  a.id AS animal_id,
  a.name AS animal_name,
  a.date_of_birth,
  v.id AS vet_id,
  v.name AS vet_name, 
  v.age AS vet_age,
  date_of_visit
  FROM visits vs INNER JOIN animals a ON a.id = vs.animal_id
  INNER JOIN vets v
  ON v.id = vs.vets_id;

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT 
  v.name AS vet_name,
  COUNT(*)
  FROM visits vs LEFT JOIN vets v ON v.id = vs.vets_id
  LEFT JOIN specializations sp 
    ON sp.vets_id = vs.vets_id
  WHERE sp.id IS NULL
  GROUP BY v.name;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most
SELECT 
  v.name AS vet_name,
  s.name AS species_name,
  COUNT(s.name)
  FROM visits vs LEFT JOIN animals a ON a.id = vs.animal_id
  LEFT JOIN vets v 
    ON v.id = vs.vets_id
  LEFT JOIN species s
    ON s.id = a.species_id
  WHERE v.name = 'Maisy Smith'
  GROUP BY v.name, s.name
  ORDER BY COUNT DESC
  LIMIT 1;

explain analyze SELECT COUNT(*) FROM visits where animal_id = 4

explain analyze SELECT * FROM visits where vet_id = 2;

explain analyze SELECT * FROM owners where email = 'owner_18327@mail.com';