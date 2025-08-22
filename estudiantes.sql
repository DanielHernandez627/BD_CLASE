-- ============================
-- Daniel Hernandez
-- Daniel Forigua
-- ============================

DROP DATABASE IF EXISTS estudiantes;
CREATE DATABASE estudiantes;
USE estudiantes;

-- ============================
-- Tabla Roles
-- ============================
CREATE TABLE `tblRoles` (
    `idRol` INT NOT NULL AUTO_INCREMENT,
    `Estado` BIT NOT NULL,
    `NombreCargo` VARCHAR(255) NOT NULL,
    PRIMARY KEY(`idRol`)
) ENGINE=InnoDB;

-- Datos de prueba Roles
INSERT INTO `tblRoles` (`Estado`, `NombreCargo`) VALUES
(1, 'Administrador'),
(1, 'Docente'),
(1, 'Estudiante');

-- ============================
-- Tabla Tipos de Identificación
-- ============================
CREATE TABLE `TipoIdentificacion` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `NombreDocumento` VARCHAR(255) NOT NULL,
    `CodigoDocumento` VARCHAR(255) NOT NULL,
    `Estado` BIT NOT NULL,
    PRIMARY KEY(`id`)
) ENGINE=InnoDB;

-- Datos de prueba Tipos de Identificación
INSERT INTO `TipoIdentificacion` (`NombreDocumento`, `CodigoDocumento`, `Estado`) VALUES
('Cédula de Ciudadanía', 'CC', 1),
('Tarjeta de Identidad', 'TI', 1),
('Cédula de Extranjería', 'CE', 1),
('Pasaporte', 'PA', 1);

-- ============================
-- Tabla Personas
-- ============================
CREATE TABLE `Persona` (
    `idPersona` INT NOT NULL AUTO_INCREMENT,
    `idRol` INT NOT NULL,
    `IdTipoIdentificacion` INT NOT NULL,
    `Correo` VARCHAR(255) NOT NULL,
    `NumeroIdentificacion` VARCHAR(255) NOT NULL,
    `Nombre` VARCHAR(255) NOT NULL,
    `Estado` BIT NOT NULL,
    `FechaRegistro` DATETIME NOT NULL,
    PRIMARY KEY(`idPersona`),
    FOREIGN KEY(`idRol`) REFERENCES `tblRoles`(`idRol`),
    FOREIGN KEY(`IdTipoIdentificacion`) REFERENCES `TipoIdentificacion`(`id`)
) ENGINE=InnoDB;

-- Datos de prueba Personas
INSERT INTO `Persona` (`idRol`, `IdTipoIdentificacion`, `Correo`, `NumeroIdentificacion`, `Nombre`, `Estado`, `FechaRegistro`) VALUES
(1, 1, 'admin@universidad.edu', '101000001', 'Carlos Ramírez', 1, NOW()),
(2, 1, 'docente1@universidad.edu', '101000002', 'María Gómez', 1, NOW()),
(2, 3, 'docente2@universidad.edu', '200000123', 'Andrés Torres', 1, NOW()),
(3, 2, 'estudiante1@universidad.edu', '500000111', 'Daniel Hernandez', 1, NOW()),
(3, 2, 'estudiante2@universidad.edu', '500000112', 'Laura Rodríguez', 1, NOW()),
(3, 4, 'estudiante3@universidad.edu', 'XK12345', 'John Smith', 1, NOW());

-- ============================
-- Tabla Clases
-- ============================
CREATE TABLE `Clases` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `NombreClase` VARCHAR(255) NOT NULL,
    `CodigoClase` INT NOT NULL,
    `Estado` BIT NOT NULL,
    PRIMARY KEY(`id`)
) ENGINE=InnoDB;

-- Datos de prueba Clases
INSERT INTO `Clases` (`NombreClase`, `CodigoClase`, `Estado`) VALUES
('Matemáticas', 101, 1),
('Programación', 102, 1),
('Física', 103, 1),
('Bases de Datos', 104, 1);

-- ============================
-- Tabla Gestión de Tutorías
-- ============================
CREATE TABLE `GestionTutorias` (
    `idTutoria` INT NOT NULL AUTO_INCREMENT,
    `IdDocente` INT NOT NULL,
    `IdEstudiante` INT NOT NULL,
    `Fecha` DATE NOT NULL,
    `Hora` TIME NOT NULL,
    `Tema` VARCHAR(255) NOT NULL,
    PRIMARY KEY(`idTutoria`),
    FOREIGN KEY(`IdDocente`) REFERENCES `Persona`(`idPersona`),
    FOREIGN KEY(`IdEstudiante`) REFERENCES `Persona`(`idPersona`)
) ENGINE=InnoDB;

-- Datos de prueba Tutorías
INSERT INTO `GestionTutorias` (`IdDocente`, `IdEstudiante`, `Fecha`, `Hora`, `Tema`) VALUES
(2, 4, '2025-08-21', '10:00:00', 'Repaso de matemáticas'),
(3, 5, '2025-08-22', '14:00:00', 'Introducción a la programación');

-- ============================
-- Tabla Gestión de Clases por Docente
-- ============================
CREATE TABLE `GestionClasesDocente` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `idDocente` INT NOT NULL,
    `idAula` INT NOT NULL,
    `idClase` INT NOT NULL,
    PRIMARY KEY(`id`),
    FOREIGN KEY(`idDocente`) REFERENCES `Persona`(`idPersona`),
    FOREIGN KEY(`idClase`) REFERENCES `Clases`(`id`)
) ENGINE=InnoDB;

-- Datos de prueba Clases Docente
INSERT INTO `GestionClasesDocente` (`idDocente`, `idAula`, `idClase`) VALUES
(2, 101, 1),
(2, 102, 2),
(3, 201, 3);

-- ============================
-- Tabla Gestión de Clases por Estudiantes
-- ============================
CREATE TABLE `GestionClasesEstudiantes` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `idEstudiante` INT NOT NULL,
    `idAula` INT NOT NULL,
    `idClase` INT NOT NULL,
    PRIMARY KEY(`id`),
    FOREIGN KEY(`idEstudiante`) REFERENCES `Persona`(`idPersona`),
    FOREIGN KEY(`idClase`) REFERENCES `Clases`(`id`)
) ENGINE=InnoDB;

-- Datos de prueba Clases Estudiantes
INSERT INTO `GestionClasesEstudiantes` (`idEstudiante`, `idAula`, `idClase`) VALUES
(4, 101, 1),
(5, 102, 2),
(6, 201, 3),
(4, 104, 4);
