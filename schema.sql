/* Database schema to keep the structure of entire database. */

     CREATE TABLE animals (
         id BIGSERIAL PRIMARY KEY NOT NULL,
         name VARCHAR(100) NOT NULL,
         date_of_birth DATE NOT NULL,
         escape_attempts INT NOT NULL,
         neutered BOOLEAN NOT NULL,
         weight_kg DECIMAL
);

-- Add a column species of type string to your animals table. 
ALTER TABLE animals 
ADD species VARCHAR(100)

-- Create a table named owners
CREATE TABLE owners (
    id BIGSERIAL PRIMARY KEY NOT NULL,
    full_name VARCHAR(100),
    age INT NOT NULL

);

-- Create a table named species
CREATE TABLE species (
    id BIGSERIAL PRIMARY KEY NOT NULL,
    name VARCHAR(100)
);

-- Remove column species
ALTER TABLE animals DROP species;

-- Add column species_id which is a foreign key referencing species table
ALTER TABLE animals 
 ADD species_id INT, 
 ADD CONSTRAINT fk_species 
 FOREIGN KEY (species_id) 
 REFERENCES species (id);

 -- Add column owner_id which is a foreign key referencing the owners table
 ALTER TABLE animals 
  ADD owner_id,
  ADD CONSTRAINT fk_owners
  FOREIGN KEY (owner_id) 
  REFERENCES owners (id);

  -- Create vets table
  CREATE TABLE vets (
      id BIGSERIAL PRIMARY KEY NOT NULL,
      name VARCHAR(100),
      age INT NOT NULL,
      date_of_graduation DATE NOT NULL
  );

  --Specialization table
CREATE TABLE specializations (
    species_id INT NOT NULL,
    vet_id INT NOT NULL,
    FOREIGN KEY (species_id) REFERENCES species (id),
    FOREIGN KEY (vet_id) REFERENCES vets (id) 
);

--Visit table
CREATE TABLE visits (
    animal_id INT NOT NULL,
    vet_id INT NOT NULL,
    date_of_visit DATE,
    FOREIGN KEY (animal_id) REFERENCES animals (id),
    FOREIGN KEY (vet_id) REFERENCES vets (id) 
);