-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema ProyectoProgra
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema ProyectoProgra
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ProyectoProgra` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `ProyectoProgra` ;

-- -----------------------------------------------------
-- Table `ProyectoProgra`.`RM_FAMILIA`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProyectoProgra`.`RM_FAMILIA` ;

CREATE TABLE IF NOT EXISTS `ProyectoProgra`.`RM_FAMILIA` (
  `FAMILIA_ID` INT NOT NULL AUTO_INCREMENT,
  `APELLIDO_PATERNO` VARCHAR(45) NOT NULL,
  `APELLIDO_MATERNO` VARCHAR(45) NOT NULL,
  `NUM_TELF` VARCHAR(12) NULL DEFAULT NULL,
  `CORREO_ELECTRONICO` VARCHAR(45) NULL DEFAULT NULL,
  `DIRECCION` VARCHAR(100) NULL DEFAULT NULL,
  `ACTIVO` TINYINT NOT NULL,
  PRIMARY KEY (`FAMILIA_ID`))
ENGINE = InnoDB
AUTO_INCREMENT = 60
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `ProyectoProgra`.`RM_ALUMNO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProyectoProgra`.`RM_ALUMNO` ;

CREATE TABLE IF NOT EXISTS `ProyectoProgra`.`RM_ALUMNO` (
  `ALUMNO_ID` INT NOT NULL AUTO_INCREMENT,
  `DNI` INT NOT NULL,
  `NOMBRE` VARCHAR(45) NOT NULL,
  `FECHA_NACIMIENTO` DATE NULL DEFAULT NULL,
  `FECHA_INGRESO` DATE NOT NULL,
  `SEXO` CHAR(1) NOT NULL,
  `RELIGION` VARCHAR(45) NULL DEFAULT NULL,
  `OBSERVACIONES` VARCHAR(120) NULL DEFAULT NULL,
  `PENSION_BASE` DECIMAL(10,2) NULL DEFAULT NULL,
  `FAMILIA_ID` INT NOT NULL,
  `ACTIVO` TINYINT NOT NULL,
  PRIMARY KEY (`ALUMNO_ID`, `FAMILIA_ID`),
  INDEX `fk_RM_ALUMNO_RM_FAMILIA_idx` (`FAMILIA_ID` ASC) VISIBLE,
  CONSTRAINT `FK_ALUMNO_FAMILIA`
    FOREIGN KEY (`FAMILIA_ID`)
    REFERENCES `ProyectoProgra`.`RM_FAMILIA` (`FAMILIA_ID`))
ENGINE = InnoDB
AUTO_INCREMENT = 47
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `ProyectoProgra`.`RM_CARGO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProyectoProgra`.`RM_CARGO` ;

CREATE TABLE IF NOT EXISTS `ProyectoProgra`.`RM_CARGO` (
  `ID_CARGO` INT NOT NULL AUTO_INCREMENT,
  `NOMBRE` VARCHAR(69) NOT NULL,
  `ACTIVO` TINYINT(1) NULL DEFAULT NULL,
  PRIMARY KEY (`ID_CARGO`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `ProyectoProgra`.`RM_GRADO_ACADEMICO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProyectoProgra`.`RM_GRADO_ACADEMICO` ;

CREATE TABLE IF NOT EXISTS `ProyectoProgra`.`RM_GRADO_ACADEMICO` (
  `GRADO_ACADEMICO_ID` INT NOT NULL AUTO_INCREMENT,
  `NOMBRE` VARCHAR(45) NOT NULL,
  `ABREVIATURA` VARCHAR(10) NULL DEFAULT NULL,
  `ACTIVO` TINYINT NOT NULL,
  PRIMARY KEY (`GRADO_ACADEMICO_ID`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `ProyectoProgra`.`RM_CURSO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProyectoProgra`.`RM_CURSO` ;

CREATE TABLE IF NOT EXISTS `ProyectoProgra`.`RM_CURSO` (
  `CURSO_ID` INT NOT NULL AUTO_INCREMENT,
  `NOMBRE` VARCHAR(45) NOT NULL,
  `DESCRIPCION` VARCHAR(100) NOT NULL,
  `HORAS_SEMANALES` INT NOT NULL,
  `ACTIVO` TINYINT NOT NULL,
  `ABREVIATURA` VARCHAR(10) NULL DEFAULT NULL,
  `GRADO_ACADEMICO_ID` INT NOT NULL,
  PRIMARY KEY (`CURSO_ID`),
  INDEX `FK_CURSO_GRD_ACD` (`GRADO_ACADEMICO_ID` ASC) VISIBLE,
  CONSTRAINT `fk_RM_CURSO_RM_GRD_ACADEMICO`
    FOREIGN KEY (`GRADO_ACADEMICO_ID`)
    REFERENCES `ProyectoProgra`.`RM_GRADO_ACADEMICO` (`GRADO_ACADEMICO_ID`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `ProyectoProgra`.`RM_TIPO_DEUDA`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProyectoProgra`.`RM_TIPO_DEUDA` ;

CREATE TABLE IF NOT EXISTS `ProyectoProgra`.`RM_TIPO_DEUDA` (
  `ID_TIPO_DEUDA` INT NOT NULL AUTO_INCREMENT,
  `DESCRIPCION` VARCHAR(45) NOT NULL,
  `MONTO_GENERAL` DECIMAL(10,2) NOT NULL,
  `ACTIVO` TINYINT NOT NULL,
  PRIMARY KEY (`ID_TIPO_DEUDA`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ProyectoProgra`.`RM_DEUDA`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProyectoProgra`.`RM_DEUDA` ;

CREATE TABLE IF NOT EXISTS `ProyectoProgra`.`RM_DEUDA` (
  `DEUDA_ID` INT NOT NULL AUTO_INCREMENT,
  `MONTO` DECIMAL(10,2) NOT NULL,
  `ACTIVO` TINYINT NOT NULL,
  `FECHA_EMISION` DATE NOT NULL,
  `FECHA_VENCIMIENTO` DATE NOT NULL,
  `DESCRIPCION` VARCHAR(100) NULL DEFAULT NULL,
  `DESCUENTO` DECIMAL(10,2) NULL DEFAULT '0.00',
  `ALUMNO_ID` INT NOT NULL,
  `ID_TIPO_DEUDA` INT NOT NULL,
  PRIMARY KEY (`DEUDA_ID`),
  INDEX `FK_DEUDA_ALUMNO` (`ALUMNO_ID` ASC) INVISIBLE,
  INDEX `fk_RM_DEUDA_RM_TIPO_DEUDA1_idx` (`ID_TIPO_DEUDA` ASC) VISIBLE,
  CONSTRAINT `FK_DEUDA_ALUMNO`
    FOREIGN KEY (`ALUMNO_ID`)
    REFERENCES `ProyectoProgra`.`RM_ALUMNO` (`ALUMNO_ID`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_RM_DEUDA_RM_TIPO_DEUDA1`
    FOREIGN KEY (`ID_TIPO_DEUDA`)
    REFERENCES `ProyectoProgra`.`RM_TIPO_DEUDA` (`ID_TIPO_DEUDA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 25
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `ProyectoProgra`.`RM_PERIODO_ACADEMICO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProyectoProgra`.`RM_PERIODO_ACADEMICO` ;

CREATE TABLE IF NOT EXISTS `ProyectoProgra`.`RM_PERIODO_ACADEMICO` (
  `PERIODO_ACADEMICO_ID` INT NOT NULL AUTO_INCREMENT,
  `NOMBRE` VARCHAR(45) NOT NULL,
  `DESCRIPCION` VARCHAR(100) NULL DEFAULT NULL,
  `FECHA_INICIO` DATE NOT NULL,
  `FECHA_FIN` DATE NOT NULL,
  `ACTIVO` TINYINT(1) NOT NULL,
  PRIMARY KEY (`PERIODO_ACADEMICO_ID`))
ENGINE = InnoDB
AUTO_INCREMENT = 16
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `ProyectoProgra`.`RM_AULA`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProyectoProgra`.`RM_AULA` ;

CREATE TABLE IF NOT EXISTS `ProyectoProgra`.`RM_AULA` (
  `ID_AULA` INT NOT NULL AUTO_INCREMENT,
  `NOMBRE` VARCHAR(45) NOT NULL,
  `GRADO_ACADEMICO_ID` INT NOT NULL,
  `ACTIVO` TINYINT NOT NULL,
  PRIMARY KEY (`ID_AULA`),
  INDEX `fk_RM_AULA_RM_GRADO_ACADEMICO1_idx` (`GRADO_ACADEMICO_ID` ASC) VISIBLE,
  CONSTRAINT `fk_RM_AULA_RM_GRADO_ACADEMICO1`
    FOREIGN KEY (`GRADO_ACADEMICO_ID`)
    REFERENCES `ProyectoProgra`.`RM_GRADO_ACADEMICO` (`GRADO_ACADEMICO_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- ======================================
-- TABLA INTERMEDIA (con ID artificial)
-- ======================================
DROP TABLE IF EXISTS `ProyectoProgra`.`RM_PERIODOxAULA`;

CREATE TABLE IF NOT EXISTS `ProyectoProgra`.`RM_PERIODOxAULA` (
  `PERIODO_AULA_ID` INT NOT NULL AUTO_INCREMENT,   -- Nueva PK
  `PERIODO_ACADEMICO_ID` INT NOT NULL,
  `ID_AULA` INT NOT NULL,
  `VACANTES_DISPONIBLES` INT NULL,
  `VACANTES_OCUPADAS` INT NULL,
  `ACTIVO` TINYINT NOT NULL,
  PRIMARY KEY (`PERIODO_AULA_ID`),
  UNIQUE (`PERIODO_ACADEMICO_ID`, `ID_AULA`),  -- evita duplicados
  INDEX `fk_PERIODO_AULA_AULA_idx` (`ID_AULA` ASC) VISIBLE,
  INDEX `fk_PERIODO_AULA_PERIODO_idx` (`PERIODO_ACADEMICO_ID` ASC) VISIBLE,
  CONSTRAINT `fk_PERIODO_AULA_PERIODO`
    FOREIGN KEY (`PERIODO_ACADEMICO_ID`)
    REFERENCES `ProyectoProgra`.`RM_PERIODO_ACADEMICO` (`PERIODO_ACADEMICO_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PERIODO_AULA_AULA`
    FOREIGN KEY (`ID_AULA`)
    REFERENCES `ProyectoProgra`.`RM_AULA` (`ID_AULA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- ======================================
-- TABLA MATRÍCULA (más limpia)
-- ======================================
DROP TABLE IF EXISTS `ProyectoProgra`.`RM_MATRICULA`;

CREATE TABLE IF NOT EXISTS `ProyectoProgra`.`RM_MATRICULA` (
  `MATRICULA_ID` INT NOT NULL AUTO_INCREMENT,
  `ALUMNO_ID` INT NOT NULL,
  `PERIODO_AULA_ID` INT NOT NULL,     -- FK directo a la tabla intermedia
  `ACTIVO` TINYINT NOT NULL,
  `COSTO_MATRICULA` DECIMAL(10,2) NULL, -- Creo que esto crashea
  `COSTO_PENSION` DECIMAL(10,2) NULL,
  PRIMARY KEY (`MATRICULA_ID`),
  UNIQUE (`ALUMNO_ID`, `PERIODO_AULA_ID`), -- evita que un alumno se duplique en el mismo periodo+aula
  INDEX `fk_MATRICULA_ALUMNO_idx` (`ALUMNO_ID` ASC) VISIBLE,
  INDEX `fk_MATRICULA_PERIODO_AULA_idx` (`PERIODO_AULA_ID` ASC) VISIBLE,
  CONSTRAINT `FK_MATRICULA_ALUMNO`
    FOREIGN KEY (`ALUMNO_ID`)
    REFERENCES `ProyectoProgra`.`RM_ALUMNO` (`ALUMNO_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_MATRICULA_PERIODO_AULA`
    FOREIGN KEY (`PERIODO_AULA_ID`)
    REFERENCES `ProyectoProgra`.`RM_PERIODOxAULA` (`PERIODO_AULA_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
)
ENGINE = InnoDB
AUTO_INCREMENT = 10
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;



-- -----------------------------------------------------
-- Table `ProyectoProgra`.`RM_PAGO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProyectoProgra`.`RM_PAGO` ;

CREATE TABLE IF NOT EXISTS `ProyectoProgra`.`RM_PAGO` (
  `PAGO_ID` INT NOT NULL AUTO_INCREMENT,
  `MONTO` DECIMAL(10,2) NOT NULL,
  `FECHA` DATETIME NOT NULL,
  `MEDIO` ENUM('EFECTIVO', 'TARJETA', 'TRANSFERENCIA', 'DEPOSITO') NOT NULL,
  `OBSERVACIONES` VARCHAR(100) NULL DEFAULT NULL,
  `DEUDA_ID` INT NOT NULL,
  `ACTIVO` TINYINT NOT NULL,
  PRIMARY KEY (`PAGO_ID`),
  INDEX `fk_RM_PAGO_RM_DEUDA1_idx` (`DEUDA_ID` ASC) VISIBLE,
  CONSTRAINT `FK_PAGO_DEUDA`
    FOREIGN KEY (`DEUDA_ID`)
    REFERENCES `ProyectoProgra`.`RM_DEUDA` (`DEUDA_ID`))
ENGINE = InnoDB
AUTO_INCREMENT = 13
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `ProyectoProgra`.`RM_PERSONAL`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProyectoProgra`.`RM_PERSONAL` ;

CREATE TABLE IF NOT EXISTS `ProyectoProgra`.`RM_PERSONAL` (
  `ID_PERSONAL` INT NOT NULL AUTO_INCREMENT,
  `ACTIVO` TINYINT(1) NOT NULL,
  `NOMBRE` VARCHAR(45) NOT NULL,
  `APELLIDO_PATERNO` VARCHAR(45) NOT NULL,
  `APELLIDO_MATERNO` VARCHAR(45) NOT NULL,
  `CORREO_ELECTRONICO` VARCHAR(45) NOT NULL,
  `TELEFONO` VARCHAR(12) NOT NULL,
  `DNI` INT NOT NULL,
  `SALARIO` DECIMAL(10,2) NOT NULL,
  `FECHA_CONTRATACION` DATE NOT NULL,
  `FIN_FECHA_CONTRATO` DATE NOT NULL,
  `TIPO_CONTRATO` ENUM('COMPLETO', 'PARCIAL') NOT NULL,
  `ID_CARGO` INT NOT NULL,
  PRIMARY KEY (`ID_PERSONAL`, `ID_CARGO`),
  INDEX `fk_RM_PERSONAL_RM_CARGO1_idx` (`ID_CARGO` ASC) VISIBLE,
  CONSTRAINT `fk_RM_PERSONAL_RM_CARGO1`
    FOREIGN KEY (`ID_CARGO`)
    REFERENCES `ProyectoProgra`.`RM_CARGO` (`ID_CARGO`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `ProyectoProgra`.`RM_USUARIO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProyectoProgra`.`RM_USUARIO` ;

CREATE TABLE IF NOT EXISTS `ProyectoProgra`.`RM_USUARIO` (
  `USUARIO_ID` INT NOT NULL AUTO_INCREMENT,
  `CLAVE_HASH` VARCHAR(256) NOT NULL,
  `NOMBRE` VARCHAR(50) NOT NULL,
  `SALT` VARCHAR(45) NOT NULL,
  `ITERACION` INT NOT NULL,
  `ACTIVO` TINYINT NOT NULL,
  `ULTIMO_ACCESO` DATETIME NOT NULL,
  `ROL` ENUM('DIRECTOR', 'PERSONAL_ADMINISTRATIVO') NOT NULL,
  PRIMARY KEY (`USUARIO_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

#=========================CRUD DE FAMILIA=========================
DROP PROCEDURE IF EXISTS INSERTAR_FAMILIA;
DELIMITER $$
CREATE PROCEDURE INSERTAR_FAMILIA (
    OUT _familia_id INT,
    IN _apellido_paterno VARCHAR(45),
    IN _apellido_materno VARCHAR(45),
    IN _num_telf VARCHAR(12),
    IN _correo_electronico VARCHAR(45),
    IN _direccion VARCHAR(100)
)
BEGIN
    INSERT INTO RM_FAMILIA(
        apellido_paterno,
        apellido_materno,
        num_telf,
        correo_electronico,
        direccion,
        activo
    ) VALUES (
        _apellido_paterno,
        _apellido_materno,
        _num_telf,
        _correo_electronico,
        _direccion,
        1
    );
    SET _familia_id = @@last_insert_id;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS MODIFICAR_FAMILIA;
DELIMITER $$
CREATE PROCEDURE MODIFICAR_FAMILIA (
    IN _familia_id INT,
    IN _apellido_paterno VARCHAR(45),
    IN _apellido_materno VARCHAR(45),
    IN _num_telf VARCHAR(12),
    IN _correo_electronico VARCHAR(45),
    IN _direccion VARCHAR(100)
)
BEGIN
	UPDATE RM_FAMILIA SET apellido_paterno = _apellido_paterno, apellido_materno = _apellido_materno, num_telf = _num_telf, correo_electronico = _correo_electronico,
		direccion = _direccion WHERE familia_id = _familia_id AND activo = 1;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS ELIMINAR_FAMILIA;
DELIMITER $$
CREATE PROCEDURE ELIMINAR_FAMILIA (
    IN _familia_id INT
)
BEGIN
	DECLARE v_alumnos_ligados INT DEFAULT 0;
	
	SELECT COUNT(*) INTO v_alumnos_ligados
    FROM RM_ALUMNO
    WHERE FAMILIA_ID = _familia_id AND activo = 1;

    IF v_alumnos_ligados > 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'No se puede eliminar la familia porque tiene alumnos asociados.';
	ELSE
		UPDATE RM_FAMILIA SET activo = 0 WHERE familia_id = _familia_id;
	END IF;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS OBTENER_FAMILIA_POR_ID;
DELIMITER $$
CREATE PROCEDURE OBTENER_FAMILIA_POR_ID (
    IN _familia_id INT
)
BEGIN
	SELECT
		familia_id,
		apellido_paterno,
        apellido_materno,
        num_telf,
        correo_electronico,
        direccion
	FROM RM_FAMILIA
    WHERE familia_id = _familia_id
		AND activo = 1;
END $$
DELIMITER ;
DROP PROCEDURE IF EXISTS LISTAR_FAMILIAS;
DELIMITER $$
CREATE PROCEDURE LISTAR_FAMILIAS ()
BEGIN
	SELECT
		familia_id,
		apellido_paterno,
        apellido_materno,
        num_telf,
        correo_electronico,
        direccion
	FROM RM_FAMILIA
    WHERE activo = 1
    ORDER BY familia_id;
END $$
DELIMITER ;

#=========================CRUD DE ALUMNO=========================
DROP PROCEDURE IF EXISTS INSERTAR_ALUMNO;
DELIMITER $$
CREATE PROCEDURE INSERTAR_ALUMNO (
	OUT _alumno_id INT,
    IN _dni INT,
    IN _nombre VARCHAR(45),
    IN _fecha_nacimiento DATE,
    IN _fecha_ingreso DATE,
    IN _sexo CHAR(1),
    IN _religion VARCHAR(45),
    IN _observaciones VARCHAR(120),
    IN _pension_base DECIMAL(10,2),
    IN _familia_id INT
)
BEGIN
    INSERT INTO RM_ALUMNO(
        dni,
        nombre,
        fecha_nacimiento,
        fecha_ingreso,
        sexo,
        religion,
        observaciones,
        pension_base,
        familia_id,
        activo
    ) VALUES (
        _dni,
        _nombre,
        _fecha_nacimiento,
        _fecha_ingreso,
        _sexo,
        _religion,
        _observaciones,
        _pension_base,
        _familia_id,
        1
    );
    SET _alumno_id = @@last_insert_id;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS MODIFICAR_ALUMNO;
DELIMITER $$
CREATE PROCEDURE MODIFICAR_ALUMNO (
    IN _alumno_id INT,
    IN _dni INT,
    IN _nombre VARCHAR(45),
    IN _fecha_nacimiento DATE,
    IN _fecha_ingreso DATE,
    IN _sexo CHAR(1),
    IN _religion VARCHAR(45),
    IN _observaciones VARCHAR(120),
    IN _pension_base DECIMAL(10,2),
    IN _familia_id INT
)
BEGIN
	UPDATE RM_ALUMNO SET dni = _dni, nombre = _nombre, fecha_nacimiento = _fecha_nacimiento, fecha_ingreso = _fecha_ingreso, sexo = _sexo, religion = _religion,
		observaciones = _observaciones, pension_base = _pension_base, familia_id = _familia_id WHERE alumno_id = _alumno_id AND activo = 1;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS ELIMINAR_ALUMNO;
DELIMITER $$
CREATE PROCEDURE ELIMINAR_ALUMNO (
    IN _alumno_id INT
)
BEGIN
	DECLARE v_deudas_ligadas INT DEFAULT 0;
	
	SELECT COUNT(*) INTO v_deudas_ligadas
    FROM RM_DEUDA
    WHERE alumno_id = _alumno_id AND activo = 1;

    IF v_deudas_ligadas > 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'No se puede eliminar el alumno porque tiene deudas asociadas.';
	ELSE
		UPDATE RM_ALUMNO SET activo = 0 WHERE alumno_id = _alumno_id;
	END IF;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS OBTENER_ALUMNO_POR_ID;
DELIMITER $$
CREATE PROCEDURE OBTENER_ALUMNO_POR_ID (
    IN _alumno_id INT
)
BEGIN
	SELECT
		a.alumno_id,
		a.dni,
		a.nombre,
		a.fecha_nacimiento,
		a.fecha_ingreso,
		a.sexo,
		a.religion,
		a.observaciones,
		a.pension_base,
		a.familia_id,
		f.apellido_paterno,
		f.apellido_paterno,
        f.apellido_materno,
        f.num_telf,
        f.correo_electronico,
        f.direccion
	FROM RM_ALUMNO a
	INNER JOIN RM_FAMILIA f ON f.familia_id=a.familia_id
    WHERE alumno_id = _alumno_id
		AND a.activo = 1
		AND f.activo = 1;
END $$
DELIMITER ;
DROP PROCEDURE IF EXISTS INSERTAR_DEUDA;
DROP PROCEDURE IF EXISTS LISTAR_ALUMNOS;
delimiter $
CREATE PROCEDURE LISTAR_ALUMNOS()
BEGIN
	SELECT
		a.alumno_id,
		a.dni,
		a.nombre,
		a.fecha_nacimiento,
		a.fecha_ingreso,
		a.sexo,
		a.religion,
		a.observaciones,
		a.pension_base,
		a.familia_id,
		f.apellido_paterno,
        f.apellido_materno,
        f.num_telf,
        f.correo_electronico,
        f.direccion
	FROM RM_ALUMNO a
	INNER JOIN RM_FAMILIA f ON f.familia_id=a.familia_id
    WHERE	a.activo = 1
		AND f.activo = 1
    ORDER BY alumno_id;
END$
DELIMITER $$

#=========================CRUD DE DEUDA=========================

DELIMITER $$
CREATE PROCEDURE INSERTAR_DEUDA (
	OUT _deuda_id INT,
    IN _monto DECIMAL(10,2),
    IN _id_tipo_deuda int,
    IN _fecha_emision DATETIME,
    IN _fecha_vencimiento DATETIME,
    IN _descripcion VARCHAR(100),
    IN _descuento DECIMAL(10,2),
    IN _alumno_id INT
)
BEGIN
    INSERT INTO RM_DEUDA(
        monto,
        id_tipo_deuda,
        fecha_emision,
        fecha_vencimiento,
        descripcion,
        descuento,
        alumno_id,
        activo
    ) VALUES (
        _monto,
        _id_tipo_deuda,
        _fecha_emision,
        _fecha_vencimiento,
        _descripcion,
        _descuento,
        _alumno_id,
        1
    );
    SET _deuda_id = @@last_insert_id;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS MODIFICAR_DEUDA;
DELIMITER $$
CREATE PROCEDURE MODIFICAR_DEUDA (
    IN _deuda_id INT,
    IN _monto DECIMAL(10,2),
    IN _id_tipo_deuda int,
    IN _fecha_emision DATETIME,
    IN _fecha_vencimiento DATETIME,
    IN _descripcion VARCHAR(100),
    IN _descuento DECIMAL(10,2),
    IN _alumno_id INT
)
BEGIN
	UPDATE RM_DEUDA SET monto = _monto, id_tipo_deuda = _id_tipo_deuda, fecha_emision = _fecha_emision, fecha_vencimiento = _fecha_vencimiento,
	descripcion = _descripcion, descuento = _descuento, alumno_id = _alumno_id WHERE deuda_id = _deuda_id AND activo = 1;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS ELIMINAR_DEUDA;
DELIMITER $$
CREATE PROCEDURE ELIMINAR_DEUDA (
    IN _deuda_id INT
)
BEGIN
	DECLARE v_pagos_ligados INT DEFAULT 0;
	
	SELECT COUNT(*) INTO v_pagos_ligados
    FROM RM_PAGO
    WHERE deuda_id = _deuda_id AND activo = 1;

    IF v_pagos_ligados > 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'No se puede eliminar la deuda porque tiene pagos asociados.';
	ELSE
		UPDATE RM_DEUDA SET activo = 0 WHERE deuda_id = _deuda_id;
	END IF;
END $$
DELIMITER ;



#ACTUALIZADO 16/11/2025:
DROP PROCEDURE IF EXISTS OBTENER_DEUDA_POR_ID;
DELIMITER $$
CREATE PROCEDURE OBTENER_DEUDA_POR_ID (
    IN _deuda_id INT
)
BEGIN
	SELECT
		d.deuda_id,
		d.monto,
        d.id_tipo_deuda AS id_tipo_deuda,
		t.descripcion     AS descripcion_tipo_deuda,
        t.monto_general   AS monto_general_tipo,
        d.fecha_emision,
        d.fecha_vencimiento,
        d.descripcion     AS descripcion_deuda,
        d.descuento,
        d.alumno_id,
        a.dni,
        a.nombre,
        a.fecha_nacimiento,
        a.fecha_ingreso,
        a.sexo,
        a.religion,
        a.observaciones,
        a.pension_base,
        a.familia_id,
		f.apellido_paterno,
        f.apellido_materno,
        f.num_telf,
        f.correo_electronico,
        f.direccion
	FROM RM_DEUDA d
    INNER JOIN RM_TIPO_DEUDA t ON t.id_tipo_deuda = d.id_tipo_deuda
    INNER JOIN RM_ALUMNO a     ON d.ALUMNO_ID = a.ALUMNO_ID
    INNER JOIN RM_FAMILIA f    ON f.FAMILIA_ID = a.FAMILIA_ID
    WHERE d.deuda_id = _deuda_id
      AND d.activo = 1
      AND a.activo = 1
      AND f.activo = 1
      AND t.activo = 1;
END $$
DELIMITER ;

desc RM_DEUDA;

#ACTUALIZADO: 16/11/2025:
DROP PROCEDURE IF EXISTS LISTAR_DEUDAS;
DELIMITER $$
CREATE PROCEDURE LISTAR_DEUDAS ()
BEGIN
	SELECT
		d.ID_TIPO_DEUDA         AS id_tipo_deuda,
		d.deuda_id,
		d.monto,
		t.descripcion           AS descripcion_tipo_deuda,
		t.monto_general         AS monto_general_tipo,
        d.fecha_emision,
        d.fecha_vencimiento,
        d.descripcion           AS descripcion_deuda,
        d.descuento,
        d.alumno_id,
        a.dni,
        a.nombre,
        a.fecha_nacimiento,
        a.fecha_ingreso,
        a.sexo,
        a.religion,
        a.observaciones,
        a.pension_base,
        a.familia_id,
		f.apellido_paterno,
        f.apellido_materno,
        f.num_telf,
        f.correo_electronico,
        f.direccion
	FROM RM_DEUDA d
    INNER JOIN RM_TIPO_DEUDA t ON t.id_tipo_deuda = d.id_tipo_deuda
    INNER JOIN RM_ALUMNO a     ON d.ALUMNO_ID = a.ALUMNO_ID
    INNER JOIN RM_FAMILIA f    ON f.FAMILIA_ID = a.FAMILIA_ID
    WHERE  d.activo = 1
      AND a.activo = 1
      AND f.activo = 1
      AND t.activo = 1
    ORDER BY d.deuda_id;
END $$
DELIMITER ;


#=========================CRUD DE PAGO=========================
desc RM_PAGO;
DROP PROCEDURE IF EXISTS INSERTAR_PAGO;
DELIMITER $$
CREATE PROCEDURE INSERTAR_PAGO (
	OUT _pago_id INT,
    IN _monto DECIMAL(10,2),
    IN _fecha DATETIME,
    IN _medio ENUM('EFECTIVO', 'TARJETA', 'TRANSFERENCIA', 'DEPOSITO'),
    IN _observaciones VARCHAR(100),
    IN _deuda_id INT
)
BEGIN
    INSERT INTO RM_PAGO(
        monto,
        fecha,
        medio,
        observaciones,
        deuda_id,
        activo
    ) VALUES (
        _monto,
        _fecha,
        _medio,
        _observaciones,
        _deuda_id,
        1
    );
    SET _pago_id = @@last_insert_id;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS MODIFICAR_PAGO;
DELIMITER $$
CREATE PROCEDURE MODIFICAR_PAGO (
    IN _pago_id INT,
    IN _monto DECIMAL(10,2),
    IN _fecha DATETIME,
    IN _medio ENUM('EFECTIVO', 'TARJETA', 'TRANSFERENCIA', 'DEPOSITO'),
    IN _observaciones VARCHAR(100)
)
BEGIN
	UPDATE RM_PAGO SET monto = _monto, fecha = _fecha, medio = _medio, observaciones = _observaciones
    WHERE pago_id = _pago_id AND activo = 1;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS ELIMINAR_PAGO;
DELIMITER $$
CREATE PROCEDURE ELIMINAR_PAGO (
    IN _pago_id INT
)
BEGIN
	UPDATE RM_PAGO SET activo = 0 WHERE pago_id = _pago_id;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS OBTENER_PAGO_POR_ID;
DELIMITER $$
CREATE PROCEDURE OBTENER_PAGO_POR_ID (
    IN _pago_id INT
)
BEGIN
	SELECT
		p.pago_id,
		p.monto,
		p.fecha,
		p.medio,
		p.observaciones as pago_observacion,
		p.deuda_id,
        d.monto,
		t.descripcion,
        d.fecha_emision,
        d.fecha_vencimiento,
        d.descripcion,
        d.descuento,
        d.alumno_id,
        a.dni,
        a.nombre,
        a.fecha_nacimiento,
        a.fecha_ingreso,
        a.sexo,
        a.religion,
        a.observaciones as alumno_observacion,
        a.pension_base,
        a.familia_id,
		f.apellido_paterno,
        f.apellido_materno,
        f.num_telf,
        f.correo_electronico,
        f.direccion
	FROM RM_PAGO p
    INNER JOIN RM_DEUDA d ON d.deuda_id=p.deuda_id
    inner join RM_TIPO_DEUDA t on t.id_tipo_deuda=d.id_tipo_deuda
    INNER JOIN RM_ALUMNO a ON d.ALUMNO_ID=a.ALUMNO_ID
    INNER JOIN RM_FAMILIA f ON f.FAMILIA_ID=a.FAMILIA_ID
    WHERE p.pago_id = _pago_id
		AND p.activo = 1
      AND d.activo = 1
      AND a.activo = 1
      AND f.activo = 1;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS LISTAR_PAGOS;
DELIMITER $$
CREATE PROCEDURE LISTAR_PAGOS ()
BEGIN
	SELECT
		p.pago_id,
		p.monto,
		p.fecha,
		p.medio,
		p.observaciones as pago_observacion,
		p.deuda_id,
        d.monto,
		t.descripcion,
        d.fecha_emision,
        d.fecha_vencimiento,
        d.descripcion,
        d.descuento,
        d.alumno_id,
        a.dni,
        a.nombre,
        a.fecha_nacimiento,
        a.fecha_ingreso,
        a.sexo,
        a.religion,
        a.observaciones as alumno_observacion,
        a.pension_base,
        a.familia_id,
		f.apellido_paterno,
        f.apellido_materno,
        f.num_telf,
        f.correo_electronico,
        f.direccion
	FROM RM_PAGO p
    INNER JOIN RM_DEUDA d ON d.deuda_id=p.deuda_id
    inner join RM_TIPO_DEUDA t on t.id_tipo_deuda=d.id_tipo_deuda
    INNER JOIN RM_ALUMNO a ON d.ALUMNO_ID=a.ALUMNO_ID
    INNER JOIN RM_FAMILIA f ON f.FAMILIA_ID=a.FAMILIA_ID
    WHERE p.activo = 1
      AND d.activo = 1
      AND a.activo = 1
      AND f.activo = 1
    ORDER BY pago_id;
END $$
DELIMITER ;

#ACTUALIZADO 17/11/2025 (NUEVO)
DROP PROCEDURE IF EXISTS LISTAR_PAGOS_POR_DEUDA;
DELIMITER $$
CREATE PROCEDURE LISTAR_PAGOS_POR_DEUDA (
    IN _deuda_id INT
)
BEGIN
	SELECT
		-- PAGO
		p.pago_id,
		p.monto               AS pago_monto,
		p.fecha               AS pago_fecha,
		p.medio,
		p.observaciones       AS pago_observacion,
		p.deuda_id,

		-- DEUDA
        d.monto               AS deuda_monto,
        d.fecha_emision,
        d.fecha_vencimiento,
        d.descripcion         AS deuda_descripcion,
        d.descuento,
        d.id_tipo_deuda,
        d.alumno_id,

        -- TIPO DE DEUDA
        t.descripcion         AS tipodeuda_descripcion,

        -- ALUMNO
        a.dni,
        a.nombre,
        a.fecha_nacimiento,
        a.fecha_ingreso,
        a.sexo,
        a.religion,
        a.observaciones       AS alumno_observacion,
        a.pension_base,
        a.familia_id,

        -- FAMILIA
		f.apellido_paterno,
        f.apellido_materno,
        f.num_telf,
        f.correo_electronico,
        f.direccion

	FROM RM_PAGO p
    INNER JOIN RM_DEUDA d ON d.deuda_id = p.deuda_id
    INNER JOIN RM_TIPO_DEUDA t ON t.id_tipo_deuda = d.id_tipo_deuda
    INNER JOIN RM_ALUMNO a ON a.alumno_id = d.alumno_id
    INNER JOIN RM_FAMILIA f ON f.familia_id = a.familia_id
    WHERE p.activo = 1
      AND d.activo = 1
      AND a.activo = 1
      AND f.activo = 1
      AND p.deuda_id = _deuda_id
    ORDER BY p.pago_id;
END $$
DELIMITER ;


#=========================CRUD DE USUARIO =========================
#Este CRUD se puede usar para agregar usuarios de cualquier tipo, pero en el alcance de la TA se usará para insertar profesores
DROP PROCEDURE IF EXISTS INSERTAR_USUARIO;
DELIMITER $$
CREATE PROCEDURE `INSERTAR_USUARIO`(
    OUT _usuario_id INT,
    IN _nombre VARCHAR(50),
    IN _clave_hash VARCHAR(255),
    IN _salt VARCHAR(128),
    IN _iteracion INT,
    IN _rol ENUM('DIRECTOR', 'PERSONAL_ADMINISTRATIVO'),
    IN _ultimo_acceso DATETIME
)
BEGIN
    INSERT INTO RM_USUARIO(
        nombre,
        clave_hash,
        salt,
        iteracion,
        rol,
	    ultimo_acceso,
        activo
    ) VALUES (
        _nombre,
        _clave_hash,
        _salt,
        _iteracion,
        _rol,
        _ultimo_acceso,
        1
    );
    SET _usuario_id = @@last_insert_id;
END$$

DELIMITER ;


DROP PROCEDURE IF EXISTS MODIFICAR_USUARIO;
DELIMITER $$
CREATE PROCEDURE MODIFICAR_USUARIO (
    IN _usuario_id INT,
    IN _nombre VARCHAR(50),
    IN _clave_hash VARCHAR(255),
    IN _salt VARCHAR(128),
    IN _iteracion INT,
    IN _rol ENUM('DIRECTOR', 'PERSONAL_ADMINISTRATIVO'),
    IN _ultimo_acceso DATETIME
)
BEGIN
    UPDATE RM_USUARIO SET 
        usuario_id = _usuario_id,
        nombre = _nombre,
        clave_hash = _clave_hash,
        salt = _salt,
        iteracion = _iteracion,
        rol = _rol,
        ultimo_acceso = _ultimo_acceso
    WHERE usuario_id = _usuario_id AND activo = 1;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS ELIMINAR_USUARIO;
DELIMITER $$
CREATE PROCEDURE ELIMINAR_USUARIO (
    IN _usuario_id INT
)
BEGIN
    UPDATE RM_USUARIO SET activo = 0 WHERE usuario_id = _usuario_id;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS OBTENER_USUARIO_POR_ID;
DELIMITER $$
CREATE PROCEDURE OBTENER_USUARIO_POR_ID (
    IN _usuario_id INT
)
BEGIN
    SELECT
        usuario_id,
        nombre,
        clave_hash,
        salt,
        iteracion,
        rol,
        ultimo_acceso,
        activo
    FROM RM_USUARIO
    WHERE usuario_id = _usuario_id
        AND activo = 1;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS LISTAR_USUARIOS;
DELIMITER $$
CREATE PROCEDURE LISTAR_USUARIOS ()
BEGIN
    SELECT
        usuario_id,
        nombre,
        clave_hash,
        salt,
        iteracion,
        rol,
        ultimo_acceso,
        activo
    FROM RM_USUARIO
    WHERE activo = 1
    ORDER BY usuario_id;
END $$
DELIMITER ;

#=========================MATRICULA=========================
 desc RM_MATRICULA;
DROP PROCEDURE IF EXISTS INSERTAR_MATRICULA;
DELIMITER $$
CREATE PROCEDURE INSERTAR_MATRICULA(
  OUT _matricula_id INT,
  IN  _alumno_id INT,
  IN  _periodo_aula_id INT
)
BEGIN
  INSERT INTO RM_MATRICULA(ALUMNO_ID, PERIODO_AULA_ID, ACTIVO)
  VALUES (_alumno_id, _periodo_aula_id, 1);

  SET _matricula_id = LAST_INSERT_ID();
END $$
DELIMITER ;
 
 

 
DROP PROCEDURE IF EXISTS MODIFICAR_MATRICULA;
DELIMITER $$
CREATE PROCEDURE MODIFICAR_MATRICULA(
  IN _matricula_id INT,
  IN _periodo_aula_id INT
)
BEGIN
  
UPDATE RM_MATRICULA
     SET periodo_aula_id=_periodo_aula_id
   WHERE MATRICULA_ID=_matricula_id and activo=1;
END $$
DELIMITER ;
 

 

#ACTUALIZADO 23/11/2025
 DROP PROCEDURE IF EXISTS OBTENER_MATRICULA_POR_ID;
DELIMITER $$

CREATE PROCEDURE OBTENER_MATRICULA_POR_ID(IN _matricula_id INT)
BEGIN
  SELECT 
         m.MATRICULA_ID,
         m.ALUMNO_ID,
         m.COSTO_MATRICULA,
         m.COSTO_PENSION,
         
         pa.PERIODO_AULA_ID,
         pa.VACANTES_DISPONIBLES,
         pa.VACANTES_OCUPADAS,

   
         a.DNI,
         a.NOMBRE AS nombre_alumno,
         a.FECHA_NACIMIENTO,
         a.FECHA_INGRESO,
         a.SEXO,
         a.RELIGION,
         a.OBSERVACIONES AS alumno_observacion,
         a.PENSION_BASE,
         a.FAMILIA_ID,
         f.APELLIDO_PATERNO,
         f.APELLIDO_MATERNO,
         f.NUM_TELF,
         f.CORREO_ELECTRONICO,
         f.DIRECCION,

         
         g.GRADO_ACADEMICO_ID,
         g.NOMBRE AS grado_nombre,
         g.ABREVIATURA,

         
         p.PERIODO_ACADEMICO_ID,
         p.NOMBRE AS periodo_nombre,
         p.DESCRIPCION AS periodo_descripcion,
         p.FECHA_INICIO,
         p.FECHA_FIN,

         aul.ID_AULA,
         aul.NOMBRE AS aula_nombre

  FROM RM_MATRICULA m
    JOIN RM_ALUMNO a ON m.ALUMNO_ID = a.ALUMNO_ID
    JOIN RM_FAMILIA f ON f.FAMILIA_ID = a.FAMILIA_ID
    JOIN RM_PERIODOxAULA pa ON pa.PERIODO_AULA_ID = m.PERIODO_AULA_ID
    JOIN RM_AULA aul ON aul.ID_AULA = pa.ID_AULA
    JOIN RM_GRADO_ACADEMICO g ON g.GRADO_ACADEMICO_ID = aul.GRADO_ACADEMICO_ID
    JOIN RM_PERIODO_ACADEMICO p ON p.PERIODO_ACADEMICO_ID = pa.PERIODO_ACADEMICO_ID

  WHERE 
    m.MATRICULA_ID = _matricula_id
    AND m.ACTIVO = 1
    AND a.ACTIVO = 1
    AND f.ACTIVO = 1
    AND g.ACTIVO = 1
    AND p.ACTIVO = 1
    AND aul.ACTIVO = 1
    AND pa.ACTIVO = 1;
END $$

DELIMITER ;

 
DROP PROCEDURE IF EXISTS LISTAR_MATRICULAS;
DELIMITER $$
CREATE PROCEDURE LISTAR_MATRICULAS()
BEGIN
  SELECT 
         m.MATRICULA_ID,
         m.ALUMNO_ID,
         m.COSTO_MATRICULA,
         m.COSTO_PENSION,
		 
         -- ALUMNO Y FAMILIA
         a.DNI,
         a.NOMBRE AS nombre_alumno,
         a.FECHA_NACIMIENTO,
         a.FECHA_INGRESO,
         a.SEXO,
         a.RELIGION,
         a.OBSERVACIONES AS alumno_observacion,
         a.PENSION_BASE,
         a.FAMILIA_ID,
         f.APELLIDO_PATERNO,
         f.APELLIDO_MATERNO,
         f.NUM_TELF,
         f.CORREO_ELECTRONICO,
         f.DIRECCION,

         -- Grado académico (desde Aula → Grado)
         g.GRADO_ACADEMICO_ID,
         g.NOMBRE AS grado_nombre,
         g.ABREVIATURA,

         -- Periodo académico
         p.PERIODO_ACADEMICO_ID,
         p.NOMBRE AS periodo_nombre,
         p.DESCRIPCION AS periodo_descripcion,
         p.FECHA_INICIO,
         p.FECHA_FIN,

         -- Aula (desde PERIODOxAULA)
         aul.ID_AULA,
         aul.NOMBRE AS aula_nombre

  FROM RM_MATRICULA m
    JOIN RM_ALUMNO a ON m.ALUMNO_ID = a.ALUMNO_ID
    JOIN RM_FAMILIA f ON f.FAMILIA_ID = a.FAMILIA_ID
    JOIN RM_PERIODOxAULA pa ON pa.PERIODO_AULA_ID = m.PERIODO_AULA_ID
    JOIN RM_AULA aul ON aul.ID_AULA = pa.ID_AULA
    JOIN RM_GRADO_ACADEMICO g ON g.GRADO_ACADEMICO_ID = aul.GRADO_ACADEMICO_ID
    JOIN RM_PERIODO_ACADEMICO p ON p.PERIODO_ACADEMICO_ID = pa.PERIODO_ACADEMICO_ID

  WHERE 
	m.ACTIVO = 1
    AND a.ACTIVO = 1
    AND f.ACTIVO = 1
    AND g.ACTIVO = 1
    AND p.ACTIVO = 1
    AND aul.ACTIVO = 1
    AND pa.ACTIVO = 1;
END $$
DELIMITER ;
 
 
 
DROP PROCEDURE IF EXISTS ELIMINAR_MATRICULA;
DELIMITER $$
CREATE PROCEDURE ELIMINAR_MATRICULA (
    IN _matricula_id INT
)
BEGIN
    DECLARE v_count INT;

    
    SELECT COUNT(*) INTO v_count
    FROM RM_MATRICULA
    WHERE MATRICULA_ID = _matricula_id
      AND ACTIVO = 1;

    IF v_count = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La matrícula no existe o ya está desactivada.';
    ELSE
       
        UPDATE RM_MATRICULA 
        SET ACTIVO = 0 
        WHERE MATRICULA_ID = _matricula_id
        LIMIT 1;
    END IF;
END $$
DELIMITER ;
 
 
#=========================================================================
#=========================CRUD DE GRADO_ACADEMICO=========================
#=========================================================================
DROP PROCEDURE IF EXISTS INSERTAR_GRADO_ACADEMICO;
DELIMITER $$
CREATE PROCEDURE INSERTAR_GRADO_ACADEMICO(
  OUT _grado_academico_id INT,
  IN  _nombre VARCHAR(45),
  IN  _abreviatura VARCHAR(10)
)
BEGIN
  
  SET _nombre = TRIM(_nombre);
  SET _abreviatura = TRIM(_abreviatura);
  
   INSERT INTO RM_GRADO_ACADEMICO (NOMBRE, ABREVIATURA, ACTIVO)
  VALUES (_nombre, _abreviatura, 1);

  SET _grado_academico_id = LAST_INSERT_ID();
END $$
DELIMITER ;
 
 desc RM_GRADO_ACADEMICO;
 


 #=========================================================================
DROP PROCEDURE IF EXISTS MODIFICAR_GRADO_ACADEMICO;
DELIMITER $$
CREATE PROCEDURE MODIFICAR_GRADO_ACADEMICO(
  IN _grado_academico_id INT,
  IN _nombre VARCHAR(45),
  IN _abreviatura VARCHAR(10)
)
BEGIN
  SET _nombre = TRIM(_nombre);
  SET _abreviatura = TRIM(_abreviatura);
UPDATE RM_GRADO_ACADEMICO
  SET NOMBRE = _nombre,
      ABREVIATURA = _abreviatura
  WHERE GRADO_ACADEMICO_ID = _grado_academico_id and activo=1;
END $$
DELIMITER ;

#=========================================================================
DROP PROCEDURE IF EXISTS OBTENER_GRADO_ACADEMICO_POR_ID;
DELIMITER $$
CREATE PROCEDURE OBTENER_GRADO_ACADEMICO_POR_ID(
  IN _grado_academico_id INT
)
BEGIN
  SELECT GRADO_ACADEMICO_ID, NOMBRE, ABREVIATURA
  FROM RM_GRADO_ACADEMICO
  WHERE GRADO_ACADEMICO_ID = _grado_academico_id AND activo = 1;
END $$
DELIMITER ;

#=========================================================================
DROP PROCEDURE IF EXISTS ELIMINAR_GRADO_ACADEMICO;
DELIMITER $$
CREATE PROCEDURE ELIMINAR_GRADO_ACADEMICO (
    IN _grado_id INT
)
BEGIN
    DECLARE v_count INT;

    
    SELECT COUNT(*) INTO v_count
    FROM RM_MATRICULA m
    JOIN RM_PERIODOxAULA pa ON m.PERIODO_AULA_ID = pa.PERIODO_AULA_ID
    JOIN RM_AULA a ON pa.ID_AULA = a.ID_AULA
    WHERE a.GRADO_ACADEMICO_ID = _grado_id
      AND m.ACTIVO = 1
      AND pa.ACTIVO = 1
      AND a.ACTIVO = 1;
    IF v_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No se puede eliminar el grado académico porque tiene matrículas activas asociadas.';
    END IF;

    
    SELECT COUNT(*) INTO v_count
    FROM RM_CURSO
    WHERE GRADO_ACADEMICO_ID = _grado_id
      AND ACTIVO = 1;
    IF v_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No se puede eliminar el grado académico porque tiene cursos activos asociados.';
    END IF;

    
    UPDATE RM_GRADO_ACADEMICO
    SET ACTIVO = 0
    WHERE GRADO_ACADEMICO_ID = _grado_id
      AND ACTIVO = 1;
END $$
DELIMITER ;

#=========================================================================
DROP PROCEDURE IF EXISTS LISTAR_GRADOS_ACADEMICOS;
DELIMITER $$
CREATE PROCEDURE LISTAR_GRADOS_ACADEMICOS()
BEGIN
  SELECT GRADO_ACADEMICO_ID, NOMBRE, ABREVIATURA
  FROM RM_GRADO_ACADEMICO
  WHERE activo = 1
  ORDER BY NOMBRE;
END $$
DELIMITER ;
desc RM_CURSO;
#===============================================================
#=========================CRUD DE CURSO=========================
#===============================================================
DROP PROCEDURE IF EXISTS INSERTAR_CURSO;
DELIMITER $$
CREATE PROCEDURE INSERTAR_CURSO (
    OUT _curso_id INT,
    IN  _nombre VARCHAR(45),
    IN  _descripcion VARCHAR(100),
    IN  _horas INT,
    IN  _abreviatura VARCHAR(10),
    IN  _grado_academico_id INT
)
BEGIN
    SET _nombre = TRIM(_nombre);
    SET _descripcion = TRIM(_descripcion);
    SET _abreviatura = TRIM(_abreviatura);
    
     INSERT INTO RM_CURSO (NOMBRE, DESCRIPCION, HORAS_SEMANALES, ACTIVO, ABREVIATURA, GRADO_ACADEMICO_ID)
    VALUES (_nombre, _descripcion, _horas, 1, _abreviatura, _grado_academico_id);

    SET _curso_id = LAST_INSERT_ID();
END $$
DELIMITER ;

 
 

 
DROP PROCEDURE IF EXISTS MODIFICAR_CURSO;
DELIMITER $$
CREATE PROCEDURE MODIFICAR_CURSO (
    IN _curso_id INT,
    IN _nombre VARCHAR(45),
    IN _descripcion VARCHAR(100),
    IN _horas INT,
    IN _abreviatura VARCHAR(10),
    IN _grado_academico_id INT
)
BEGIN
    SET _nombre = TRIM(_nombre);
    SET _descripcion = TRIM(_descripcion);
    SET _abreviatura = TRIM(_abreviatura);

     UPDATE RM_CURSO
       SET NOMBRE = _nombre,
           DESCRIPCION = _descripcion,
           HORAS_SEMANALES = _horas,
           ABREVIATURA = _abreviatura,
           GRADO_ACADEMICO_ID = _grado_academico_id
     WHERE CURSO_ID = _curso_id;
END $$
DELIMITER ;

 
 


DROP PROCEDURE IF EXISTS OBTENER_CURSO_POR_ID;
DELIMITER $$
CREATE PROCEDURE OBTENER_CURSO_POR_ID (
	IN _curso_id INT
)
BEGIN
    SELECT c.CURSO_ID, c.NOMBRE as curso_nombre,
    c.DESCRIPCION, c.HORAS_SEMANALES, c.ABREVIATURA as curso_abreviatura, c.GRADO_ACADEMICO_ID,
    g.nombre as grado_nombre,
    g.abreviatura as abreviatura_grado
      FROM RM_CURSO c
      join RM_GRADO_ACADEMICO g on g.GRADO_ACADEMICO_ID=c.GRADO_ACADEMICO_ID   
     WHERE c.CURSO_ID = _curso_id AND g.ACTIVO = 1 and c.activo=1;
END $$
DELIMITER ;
 desc RM_GRADO_ACADEMICO;


DROP PROCEDURE IF EXISTS ELIMINAR_CURSO;
DELIMITER $$
CREATE PROCEDURE ELIMINAR_CURSO (
    IN _curso_id INT
)
BEGIN
    UPDATE RM_CURSO
    SET ACTIVO = 0
    WHERE CURSO_ID = _curso_id;
END $$
DELIMITER ;

 
 
 
DROP PROCEDURE IF EXISTS LISTAR_CURSOS;
DELIMITER $$
CREATE PROCEDURE LISTAR_CURSOS()
BEGIN
    SELECT c.CURSO_ID, c.NOMBRE as curso_nombre,
    c.DESCRIPCION, c.HORAS_SEMANALES, c.ABREVIATURA as curso_abreviatura, c.GRADO_ACADEMICO_ID,
    g.nombre as grado_nombre,
    g.abreviatura as abreviatura_grado
      FROM RM_CURSO c
      join RM_GRADO_ACADEMICO g on g.GRADO_ACADEMICO_ID=c.GRADO_ACADEMICO_ID   
     WHERE g.ACTIVO = 1 and c.activo=1
     ORDER BY c.CURSO_ID;
END $$
DELIMITER ;

 CALL LISTAR_CURSOS();
 


#=========================PERIODO ACADEMICO=========================

 
DROP PROCEDURE IF EXISTS INSERTAR_PERIODO_ACADEMICO;
DELIMITER $$
CREATE PROCEDURE INSERTAR_PERIODO_ACADEMICO(
  OUT _periodo_academico_id INT,
  IN  _nombre        VARCHAR(45),
  IN  _descripcion   VARCHAR(100),
  IN  _fecha_inicio  DATE,
  IN  _fecha_fin     DATE
)
BEGIN

  
  INSERT INTO RM_PERIODO_ACADEMICO(NOMBRE, DESCRIPCION, FECHA_INICIO, FECHA_FIN, ACTIVO)
  VALUES (_nombre, _descripcion, _fecha_inicio, _fecha_fin, 1);

  SET _periodo_academico_id = LAST_INSERT_ID();
END $$
DELIMITER ;

 
 
 

 
DROP PROCEDURE IF EXISTS MODIFICAR_PERIODO_ACADEMICO;
DELIMITER $$
CREATE PROCEDURE MODIFICAR_PERIODO_ACADEMICO(
  IN _periodo_academico_id INT,
  IN _nombre        VARCHAR(45),
  IN _descripcion   VARCHAR(100),
  IN _fecha_inicio  DATE,
  IN _fecha_fin     DATE
)
BEGIN
  
UPDATE RM_PERIODO_ACADEMICO
     SET NOMBRE       = _nombre,
         DESCRIPCION  = _descripcion,
         FECHA_INICIO = _fecha_inicio,
         FECHA_FIN    = _fecha_fin
   WHERE PERIODO_ACADEMICO_ID = _periodo_academico_id and activo=1;
END $$
DELIMITER ;
 
 


 
DROP PROCEDURE IF EXISTS OBTENER_PERIODO_ACADEMICO_POR_ID;
DELIMITER $$
CREATE PROCEDURE OBTENER_PERIODO_ACADEMICO_POR_ID(
  IN _periodo_academico_id INT
)
BEGIN
  SELECT PERIODO_ACADEMICO_ID, NOMBRE, DESCRIPCION, FECHA_INICIO, FECHA_FIN, ACTIVO
    FROM RM_PERIODO_ACADEMICO
   WHERE PERIODO_ACADEMICO_ID = _periodo_academico_id;
END $$
DELIMITER ;

 
DROP PROCEDURE IF EXISTS LISTAR_PERIODOS_ACADEMICOS;
DELIMITER $$
CREATE PROCEDURE LISTAR_PERIODOS_ACADEMICOS()
BEGIN
  SELECT PERIODO_ACADEMICO_ID, NOMBRE, DESCRIPCION, FECHA_INICIO, FECHA_FIN, activo
    FROM RM_PERIODO_ACADEMICO
    where activo=1
   ORDER BY FECHA_INICIO DESC;
END $$
DELIMITER ;
 
DROP PROCEDURE IF EXISTS ELIMINAR_PERIODO_ACADEMICO;
DELIMITER $$
CREATE PROCEDURE ELIMINAR_PERIODO_ACADEMICO(
  IN _periodo_academico_id INT
)
BEGIN
  DECLARE v_count INT;

  -- Verificar matrículas activas ligadas al periodo
  SELECT COUNT(*) INTO v_count
  FROM RM_MATRICULA m
  JOIN RM_PERIODOxAULA pa ON m.PERIODO_AULA_ID = pa.PERIODO_AULA_ID
  WHERE pa.PERIODO_ACADEMICO_ID = _periodo_academico_id
    AND m.ACTIVO = 1
    AND pa.ACTIVO = 1;
  
  IF v_count > 0 THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'No se puede dar de baja: existen MATRÍCULAS activas en este periodo';
  END IF;

 
  UPDATE RM_PERIODO_ACADEMICO
  SET ACTIVO = 0
  WHERE PERIODO_ACADEMICO_ID = _periodo_academico_id
    AND ACTIVO = 1;
END $$
DELIMITER ;

 -- --------------------------------------TIPO DEUDA CRUDS ------------------
DROP PROCEDURE IF EXISTS INSERTAR_TIPO_DEUDA;
DELIMITER $$
CREATE PROCEDURE INSERTAR_TIPO_DEUDA (
    out _id_tipo_deuda INT,
    IN _descripcion VARCHAR(45),
    IN _monto_general DECIMAL(10,2)
)
BEGIN
    INSERT INTO RM_TIPO_DEUDA (
        DESCRIPCION,
        MONTO_GENERAL,
        ACTIVO
    ) VALUES (
        _descripcion,
        _monto_general,
        1
    );
    SET _id_tipo_deuda = @@last_insert_id;
END $$
DELIMITER ;
DROP PROCEDURE IF EXISTS MODIFICAR_TIPO_DEUDA;
DELIMITER $$
CREATE PROCEDURE MODIFICAR_TIPO_DEUDA (
    IN _id_tipo_deuda INT,
    IN _descripcion VARCHAR(45),
    IN _monto_general DECIMAL(10,2)
)
BEGIN
    UPDATE RM_TIPO_DEUDA
    SET DESCRIPCION = _descripcion,
        MONTO_GENERAL = _monto_general
    WHERE ID_TIPO_DEUDA = _id_tipo_deuda
      AND ACTIVO = 1;
END $$
DELIMITER ;
DROP PROCEDURE IF EXISTS ELIMINAR_TIPO_DEUDA;
DELIMITER $$
CREATE PROCEDURE ELIMINAR_TIPO_DEUDA (
    IN _id_tipo_deuda INT
)
BEGIN
    DECLARE v_deudas INT DEFAULT 0;

    
    SELECT COUNT(*) INTO v_deudas
    FROM RM_DEUDA
    WHERE ID_TIPO_DEUDA = _id_tipo_deuda
      AND ACTIVO = 1;

    IF v_deudas > 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'No se puede eliminar el tipo de deuda porque tiene deudas activas asociadas.';
    ELSE
        UPDATE RM_TIPO_DEUDA
        SET ACTIVO = 0
        WHERE ID_TIPO_DEUDA = _id_tipo_deuda;
    END IF;
END $$
DELIMITER ;
DROP PROCEDURE IF EXISTS OBTENER_TIPO_DEUDA_POR_ID;
DELIMITER $$
CREATE PROCEDURE OBTENER_TIPO_DEUDA_POR_ID (
    IN _id_tipo_deuda INT
)
BEGIN
    SELECT
        ID_TIPO_DEUDA,
        DESCRIPCION,
        MONTO_GENERAL
    FROM RM_TIPO_DEUDA
    WHERE ID_TIPO_DEUDA = _id_tipo_deuda
      AND ACTIVO = 1;
END $$
DELIMITER ;
DROP PROCEDURE IF EXISTS LISTAR_TIPOS_DEUDA;
DELIMITER $$
CREATE PROCEDURE LISTAR_TIPOS_DEUDA ()
BEGIN
    SELECT
        ID_TIPO_DEUDA,
        DESCRIPCION,
        MONTO_GENERAL
    FROM RM_TIPO_DEUDA
    WHERE ACTIVO = 1
    ORDER BY ID_TIPO_DEUDA;
END $$
DELIMITER ;
#=========================CRUD DE CARGO=========================
DROP PROCEDURE IF EXISTS INSERTAR_CARGO;
DELIMITER $$
CREATE PROCEDURE INSERTAR_CARGO (
    OUT _id_cargo INT,
    IN _nombre VARCHAR(69)
)
BEGIN
    INSERT INTO RM_CARGO (
        NOMBRE,
        ACTIVO
    ) VALUES (
        _nombre,
        1
    );
    SET _id_cargo = @@last_insert_id;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS MODIFICAR_CARGO;
DELIMITER $$
CREATE PROCEDURE MODIFICAR_CARGO (
    IN _id_cargo INT,
    IN _nombre VARCHAR(69)
)
BEGIN
    UPDATE RM_CARGO
    SET NOMBRE = _nombre
    WHERE ID_CARGO = _id_cargo
      AND ACTIVO = 1;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS ELIMINAR_CARGO;
DELIMITER $$
CREATE PROCEDURE ELIMINAR_CARGO (
    IN _id_cargo INT
)
BEGIN
    DECLARE v_personal INT DEFAULT 0;

    -- Verificar si hay personal activo con este cargo
    SELECT COUNT(*) INTO v_personal
    FROM RM_PERSONAL
    WHERE ID_CARGO = _id_cargo
      AND ACTIVO = 1;

    IF v_personal > 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'No se puede eliminar el cargo porque tiene personal asociado.';
    ELSE
        UPDATE RM_CARGO
        SET ACTIVO = 0
        WHERE ID_CARGO = _id_cargo;
    END IF;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS OBTENER_CARGO_POR_ID;
DELIMITER $$
CREATE PROCEDURE OBTENER_CARGO_POR_ID (
    IN _id_cargo INT
)
BEGIN
    SELECT
        ID_CARGO,
        NOMBRE
    FROM RM_CARGO
    WHERE ID_CARGO = _id_cargo
      AND ACTIVO = 1;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS LISTAR_CARGOS;
DELIMITER $$
CREATE PROCEDURE LISTAR_CARGOS ()
BEGIN
    SELECT
        ID_CARGO,
        NOMBRE
    FROM RM_CARGO
    WHERE ACTIVO = 1
    ORDER BY ID_CARGO;
END $$
DELIMITER ;
-- =====================================
-- INSERTAR PERSONAL
-- =====================================
DROP PROCEDURE IF EXISTS INSERTAR_PERSONAL;
DELIMITER $$
CREATE PROCEDURE INSERTAR_PERSONAL (
    OUT _id_personal INT,
    IN _id_cargo INT,
    IN _nombre VARCHAR(45),
    IN _apellido_paterno VARCHAR(45),
    IN _apellido_materno VARCHAR(45),
    IN _dni INT,
    IN _correo_electronico VARCHAR(45),
    IN _telefono VARCHAR(12),
    IN _salario DECIMAL(10,2),
    IN _fecha_contratacion DATE,
    IN _fin_fecha_contrato DATE,
    IN _tipo_contrato ENUM('COMPLETO','PARCIAL')
)
BEGIN
    INSERT INTO RM_PERSONAL (
        ID_CARGO,
        NOMBRE,
        APELLIDO_PATERNO,
        APELLIDO_MATERNO,
        DNI,
        CORREO_ELECTRONICO,
        TELEFONO,
        SALARIO,
        FECHA_CONTRATACION,
        FIN_FECHA_CONTRATO,
        TIPO_CONTRATO,
        ACTIVO
    ) VALUES (
        _id_cargo,
        _nombre,
        _apellido_paterno,
        _apellido_materno,
        _dni,
        _correo_electronico,
        _telefono,
        _salario,
        _fecha_contratacion,
        _fin_fecha_contrato,
        _tipo_contrato,
        1
    );
    SET _id_personal = LAST_INSERT_ID();
END $$
DELIMITER ;

-- =====================================
-- MODIFICAR PERSONAL
-- =====================================

DROP PROCEDURE IF EXISTS MODIFICAR_PERSONAL;
DELIMITER $$
CREATE PROCEDURE MODIFICAR_PERSONAL (
    IN _id_personal INT,
    IN _id_cargo INT,
    IN _nombre VARCHAR(45),
    IN _apellido_paterno VARCHAR(45),
    IN _apellido_materno VARCHAR(45),
    IN _dni INT,
    IN _correo_electronico VARCHAR(45),
    IN _telefono VARCHAR(12),
    IN _salario DECIMAL(10,2),
    IN _fecha_contratacion DATE,
    IN _fin_fecha_contrato DATE,
    IN _tipo_contrato ENUM('COMPLETO','PARCIAL')
)
BEGIN
    UPDATE RM_PERSONAL
    SET 
        ID_CARGO = _id_cargo,
        NOMBRE = _nombre,
        APELLIDO_PATERNO = _apellido_paterno,
        APELLIDO_MATERNO = _apellido_materno,
        DNI = _dni,
        CORREO_ELECTRONICO = _correo_electronico,
        TELEFONO = _telefono,
        SALARIO = _salario,
        FECHA_CONTRATACION = _fecha_contratacion,
        FIN_FECHA_CONTRATO = _fin_fecha_contrato,
        TIPO_CONTRATO = _tipo_contrato
    WHERE ID_PERSONAL = _id_personal
      AND ACTIVO = 1;
END $$
DELIMITER ;

-- =====================================
-- ELIMINAR (lógica) PERSONAL
-- =====================================
DROP PROCEDURE IF EXISTS ELIMINAR_PERSONAL;
DELIMITER $$
CREATE PROCEDURE ELIMINAR_PERSONAL (
    IN _id_personal INT
)
BEGIN
    UPDATE RM_PERSONAL
    SET ACTIVO = 0
    WHERE ID_PERSONAL = _id_personal
      AND ACTIVO = 1;
END $$
DELIMITER ;


-- =====================================
-- OBTENER PERSONAL POR ID
-- =====================================
DROP PROCEDURE IF EXISTS OBTENER_PERSONAL_POR_ID;
DELIMITER $$
CREATE PROCEDURE OBTENER_PERSONAL_POR_ID (
    IN _id_personal INT
)
BEGIN
    SELECT
        P.ID_PERSONAL,
        P.NOMBRE,
        P.APELLIDO_PATERNO,
        P.APELLIDO_MATERNO,
		P.DNI,
        P.CORREO_ELECTRONICO,
        P.TELEFONO,
        P.SALARIO,
        P.FECHA_CONTRATACION,
        P.FIN_FECHA_CONTRATO,
        P.TIPO_CONTRATO,
        P.ID_CARGO,
        C.NOMBRE AS CARGO_DESCRIPCION
    FROM RM_PERSONAL P
    INNER JOIN RM_CARGO C ON P.ID_CARGO = C.ID_CARGO
    WHERE P.ID_PERSONAL = _id_personal
      AND P.ACTIVO = 1
      AND C.ACTIVO = 1;
END $$
DELIMITER ;


-- =====================================
-- LISTAR PERSONAL
-- =====================================
DROP PROCEDURE IF EXISTS LISTAR_PERSONAL;
DELIMITER $$
CREATE PROCEDURE LISTAR_PERSONAL ()
BEGIN
    SELECT
        P.ID_PERSONAL,
        P.NOMBRE,
        P.APELLIDO_PATERNO,
        P.APELLIDO_MATERNO,
		P.DNI,
        P.CORREO_ELECTRONICO,
        P.TELEFONO,
        P.SALARIO,
        P.FECHA_CONTRATACION,
        P.FIN_FECHA_CONTRATO,
        P.TIPO_CONTRATO,
        P.ID_CARGO,
        C.NOMBRE AS CARGO_DESCRIPCION
    FROM RM_PERSONAL P
    INNER JOIN RM_CARGO C ON P.ID_CARGO = C.ID_CARGO
    WHERE P.ACTIVO = 1
      AND C.ACTIVO = 1
    ORDER BY P.ID_PERSONAL;
END $$
DELIMITER ;
 #======================= CRUD DE RM_PERIODO_X_AULA ======================================0
 DROP PROCEDURE IF EXISTS INSERTAR_PERIODOxAULA;
DELIMITER $$
CREATE PROCEDURE INSERTAR_PERIODOxAULA (
    OUT _periodo_aula_id INT,
    IN _periodo_academico_id INT,
    IN _id_aula INT,
    IN _vacantes_disponibles INT,
    IN _vacantes_ocupadas INT
)
BEGIN
    INSERT INTO RM_PERIODOxAULA (
        PERIODO_ACADEMICO_ID,
        ID_AULA,
        VACANTES_DISPONIBLES,
        VACANTES_OCUPADAS,
        ACTIVO
    ) VALUES (
        _periodo_academico_id,
        _id_aula,
        _vacantes_disponibles,
        _vacantes_ocupadas,
        1
    );
    SET _periodo_aula_id = @@last_insert_id;
END $$
DELIMITER ;
DROP PROCEDURE IF EXISTS MODIFICAR_PERIODOxAULA;
DELIMITER $$
CREATE PROCEDURE MODIFICAR_PERIODOxAULA (
    IN _periodo_aula_id INT,
    IN _vacantes_disponibles INT,
    IN _vacantes_ocupadas INT
)
BEGIN
    UPDATE RM_PERIODOxAULA
    SET VACANTES_DISPONIBLES = _vacantes_disponibles,
        VACANTES_OCUPADAS = _vacantes_ocupadas
    WHERE PERIODO_AULA_ID = _periodo_aula_id
      AND ACTIVO = 1;
END $$
DELIMITER ;
DROP PROCEDURE IF EXISTS OBTENER_PERIODOxAULA_POR_ID;
DELIMITER $$
CREATE PROCEDURE OBTENER_PERIODOxAULA_POR_ID (
    IN _periodo_aula_id INT
)
BEGIN
    SELECT
        PA.PERIODO_AULA_ID,
        PA.VACANTES_DISPONIBLES,
        PA.VACANTES_OCUPADAS,
        P.PERIODO_ACADEMICO_ID,
        P.NOMBRE AS NOMBRE_PERIODO,
        P.FECHA_INICIO,
        P.FECHA_FIN,
        A.ID_AULA,
        A.NOMBRE AS NOMBRE_AULA,
        A.GRADO_ACADEMICO_ID
    FROM RM_PERIODOxAULA PA
    INNER JOIN RM_PERIODO_ACADEMICO P ON PA.PERIODO_ACADEMICO_ID = P.PERIODO_ACADEMICO_ID
    INNER JOIN RM_AULA A ON PA.ID_AULA = A.ID_AULA
    WHERE PA.PERIODO_AULA_ID = _periodo_aula_id
      AND PA.ACTIVO = 1
      AND P.ACTIVO = 1
      AND A.ACTIVO = 1;
END $$
DELIMITER ;
DROP PROCEDURE IF EXISTS LISTAR_PERIODOxAULA;
DELIMITER $$
CREATE PROCEDURE LISTAR_PERIODOxAULA ()
BEGIN
    SELECT
        PA.PERIODO_AULA_ID,
        PA.VACANTES_DISPONIBLES,
        PA.VACANTES_OCUPADAS,
        P.PERIODO_ACADEMICO_ID,
        P.NOMBRE AS NOMBRE_PERIODO,
        P.FECHA_INICIO,
        P.FECHA_FIN,
        A.ID_AULA,
        A.NOMBRE AS NOMBRE_AULA,
        A.GRADO_ACADEMICO_ID
    FROM RM_PERIODOxAULA PA
    INNER JOIN RM_PERIODO_ACADEMICO P ON PA.PERIODO_ACADEMICO_ID = P.PERIODO_ACADEMICO_ID
    INNER JOIN RM_AULA A ON PA.ID_AULA = A.ID_AULA
    WHERE PA.ACTIVO = 1
      AND P.ACTIVO = 1
      AND A.ACTIVO = 1
    ORDER BY PA.PERIODO_AULA_ID;
END $$
DELIMITER ;
DROP PROCEDURE IF EXISTS ELIMINAR_PERIODOxAULA;
DELIMITER $$
CREATE PROCEDURE ELIMINAR_PERIODOxAULA (
    IN _periodo_aula_id INT
)
BEGIN
    DECLARE v_count INT;

    
    SELECT COUNT(*) INTO v_count
    FROM RM_MATRICULA
    WHERE PERIODO_AULA_ID = _periodo_aula_id
      AND ACTIVO = 1;

    IF v_count > 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'No se puede eliminar el PERIODOxAULA porque tiene matrículas activas asociadas.';
    ELSE
        UPDATE RM_PERIODOxAULA
        SET ACTIVO = 0
        WHERE PERIODO_AULA_ID = _periodo_aula_id
          AND ACTIVO = 1;
    END IF;
END $$
DELIMITER ;

#================================================================================================
#==========================================CRUD DE AULA==========================================
#================================================================================================
#INSERTAR AULA
DROP PROCEDURE IF EXISTS INSERTAR_AULA;
DELIMITER $$
CREATE PROCEDURE INSERTAR_AULA (
    OUT _aula_id INT,
    IN _nombre VARCHAR(45),
    IN _grado_academico_id INT
)
BEGIN
    INSERT INTO RM_AULA(
        nombre,
        grado_academico_id,
        activo
    ) VALUES (
        _nombre,
        _grado_academico_id,
        1
    );
    SET _aula_id = @@last_insert_id;
END $$
DELIMITER ;
#================================================================================================
#MODIFICAR AULA
DROP PROCEDURE IF EXISTS MODIFICAR_AULA;
DELIMITER $$
CREATE PROCEDURE MODIFICAR_AULA (
    IN _aula_id INT,
    IN _nombre VARCHAR(45),
    IN _grado_academico_id INT
)
BEGIN
    UPDATE RM_AULA SET nombre = _nombre, grado_academico_id = _grado_academico_id WHERE id_aula = _aula_id AND activo = 1;
END $$
DELIMITER ;
#================================================================================================
#ELIMINAR AULA
DROP PROCEDURE IF EXISTS ELIMINAR_AULA;
DELIMITER $$
CREATE PROCEDURE ELIMINAR_AULA (
	IN _aula_id INT
)
BEGIN
    DECLARE v_count INT;
    
    SELECT COUNT(*) INTO v_count
    FROM RM_PERIODOxAULA
    WHERE ID_AULA = _aula_id
      AND ACTIVO = 1;

    IF v_count > 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'No se puede eliminar el AULA porque está asociada a un periodo activo.';
    ELSE
        UPDATE RM_AULA
        SET ACTIVO = 0
        WHERE ID_AULA = _aula_id
          AND ACTIVO = 1;
    END IF;
END $$
DELIMITER ;
#================================================================================================
#OBTENER AULA POR ID (ACTUALIZADO 18/11/2025)
DROP PROCEDURE IF EXISTS OBTENER_AULA_POR_ID;
DELIMITER $$
CREATE PROCEDURE OBTENER_AULA_POR_ID (
    IN _aula_id INT
)
BEGIN
    SELECT
        a.ID_AULA          AS AULA_ID,
        a.NOMBRE           AS NOMBRE_AULA,
        a.GRADO_ACADEMICO_ID,
        g.NOMBRE           AS NOMBRE_GRADO,
        g.ABREVIATURA      AS ABREVIATURA_GRADO,
        a.ACTIVO           AS ACTIVO        
    FROM RM_AULA a
    JOIN RM_GRADO_ACADEMICO g 
      ON g.GRADO_ACADEMICO_ID = a.GRADO_ACADEMICO_ID
    WHERE a.ID_AULA = _aula_id
      AND a.ACTIVO = 1
      AND g.ACTIVO = 1;
END $$
DELIMITER ;
#================================================================================================
#LISTAR AULAS ORDENADAS POR ID
DROP PROCEDURE IF EXISTS LISTAR_AULAS;
DELIMITER $$
CREATE PROCEDURE LISTAR_AULAS (
)
BEGIN
	SELECT
		a.ID_AULA as AULA_ID,
        a.NOMBRE as NOMBRE_AULA,
        a.GRADO_ACADEMICO_ID,
        g.NOMBRE as NOMBRE_GRADO,
        g.ABREVIATURA as ABREVIATURA_GRADO
    FROM RM_AULA a, RM_GRADO_ACADEMICO g
    WHERE g.GRADO_ACADEMICO_ID = a.GRADO_ACADEMICO_ID AND a.ACTIVO = 1 AND g.ACTIVO = 1
    ORDER BY a.ID_AULA;
END $$
DELIMITER ;

#================================================================================================

-- ----------------------CRUD DE BUSQUEDA FAMILIA -----------
-- -----------------------------------------------------------
DROP PROCEDURE IF EXISTS BUSCAR_FAMILIA;
DELIMITER $$
CREATE PROCEDURE BUSCAR_FAMILIA (
    IN _apellido_paterno VARCHAR(45),
	in _apellido_materno VARCHAR(45)	
)
BEGIN
	SELECT
		familia_id,
		apellido_paterno,
        apellido_materno
	FROM RM_FAMILIA
    WHERE (_apellido_paterno IS NULL OR apellido_paterno LIKE CONCAT('%',_apellido_paterno,'%')) 
		and (_apellido_materno IS NULL OR apellido_materno LIKE CONCAT('%',_apellido_materno,'%')) 
		and activo=1;
END $$

#ACTUALIZADO 16/11/2025
DELIMITER ;
DROP PROCEDURE IF EXISTS OBTENER_HIJOS_FAMILIA;
DELIMITER $$
CREATE PROCEDURE OBTENER_HIJOS_FAMILIA (
    IN _familia_id INT	
)
BEGIN
    SELECT
        a.ALUMNO_ID                           AS alumno_id,      
        CONCAT(a.nombre, ' ', f.apellido_paterno) AS nombre_alumno,
        a.dni,
        a.sexo
    FROM RM_ALUMNO a
    JOIN RM_FAMILIA f ON f.familia_id = a.familia_id
    WHERE a.familia_id = _familia_id
      AND a.activo = 1
      AND f.activo = 1;
END $$
DELIMITER ;

-- ----------------------CRUD DE BUSQUEDA ALUMNO -----------
-- -----------------------------------------------------------

DROP PROCEDURE IF EXISTS BUSCAR_ALUMNO;
DELIMITER $$
CREATE PROCEDURE BUSCAR_ALUMNO(
    IN _familia_id INT,
    IN _apellido_paterno VARCHAR(45),
    IN _apellido_materno VARCHAR(45),
    IN _nombre VARCHAR(45),
    IN _dni INT
)
BEGIN
    SELECT
        a.alumno_id,
        a.dni,
        a.familia_id,
        f.apellido_paterno,
        f.apellido_materno,
        a.sexo,
        a.nombre,
        CASE 
            WHEN a.pension_base = -1 THEN (
                SELECT t.monto_general
                FROM RM_TIPO_DEUDA t
                WHERE t.descripcion = 'MATRICULA'
                LIMIT 1
            )
            ELSE a.pension_base
        END AS pension
    FROM RM_ALUMNO a
    JOIN RM_FAMILIA f ON f.familia_id = a.familia_id
    WHERE (_apellido_paterno IS NULL OR f.apellido_paterno LIKE CONCAT('%', _apellido_paterno, '%'))
      AND (_apellido_materno IS NULL OR f.apellido_materno LIKE CONCAT('%', _apellido_materno, '%'))
      AND (_familia_id = -1 OR a.familia_id = _familia_id)
      AND (_nombre IS NULL OR a.nombre LIKE CONCAT('%', _nombre, '%'))
      AND (_dni = -1 OR a.dni LIKE CONCAT('%', _dni, '%'))
      AND a.activo = 1
      AND f.activo = 1;
END $$
DELIMITER ;
DROP PROCEDURE IF EXISTS CONSULTAR_MATRICULA_ALUMNO;
DELIMITER $$
CREATE PROCEDURE CONSULTAR_MATRICULA_ALUMNO(
	IN _alumno_id int
)
BEGIN
	SELECT
		p.fecha_inicio as fecha,
        p.nombre as periodo_nombre,
        m.activo,
        g.nombre as grado_nombre,
        a.nombre as aula_nombre
	FROM RM_MATRICULA m 
    join RM_PERIODOxAULA per on per.PERIODO_AULA_ID=m.PERIODO_AULA_ID
    join RM_PERIODO_ACADEMICO p on p.periodo_academico_id=per.periodo_academico_id
    join RM_AULA a on a.ID_AULA=per.ID_AULA
    join RM_GRADO_ACADEMICO g on g.GRADO_ACADEMICO_ID=a.GRADO_ACADEMICO_ID
    WHERE m.alumno_id=_alumno_id;
		
END $$
DELIMITER ;
-- ----------------------CRUD DE BUSQUEDA/CONSULTA MATRICULA -----------
-- -----------------------------------------------------------
DROP PROCEDURE IF EXISTS BUSCAR_ANIO_ALUMNOS_MAT;
DELIMITER $$
CREATE PROCEDURE BUSCAR_ANIO_ALUMNOS_MAT(
    IN _familia_id INT,
    IN _apellido_paterno VARCHAR(45),
    IN _apellido_materno VARCHAR(45),
    IN _nombre VARCHAR(45),
    IN _dni INT,
    IN _ano INT
)
BEGIN
    SELECT
        f.apellido_paterno,
        f.apellido_materno,
        a.sexo as genero,
        a.nombre,
        YEAR(p.fecha_inicio) as anio,
        m.PERIODO_AULA_ID,
        a.ALUMNO_ID,
        a.FAMILIA_ID
    FROM RM_ALUMNO a 
        JOIN RM_FAMILIA f ON f.familia_id=a.familia_id
        JOIN RM_MATRICULA m ON m.alumno_id=a.alumno_id
        JOIN RM_PERIODOxAULA per ON per.PERIODO_AULA_ID=m.PERIODO_AULA_ID
        JOIN RM_PERIODO_ACADEMICO p ON p.PERIODO_ACADEMICO_ID=per.PERIODO_ACADEMICO_ID
    WHERE
        
        (_apellido_paterno IS NULL OR _apellido_paterno = '' 
            OR f.apellido_paterno LIKE CONCAT('%',_apellido_paterno,'%'))
        AND (_apellido_materno IS NULL OR _apellido_materno = '' 
            OR f.apellido_materno LIKE CONCAT('%',_apellido_materno,'%'))
        AND (_nombre IS NULL OR _nombre = '' 
            OR a.nombre LIKE CONCAT('%',_nombre,'%'))

        
        AND (_familia_id IS NULL OR _familia_id = 0 
            OR a.familia_id = _familia_id)

        
        AND (_dni IS NULL OR _dni = 0 
            OR a.dni = _dni)

        
        AND YEAR(p.fecha_inicio) = _ano;
END $$
DELIMITER ;
#================ CRUDS DE BUSQUEDA/CONSULTA PARA AREA COBRANZA ===============================
#ACTUALIZADO 16/11/2025: 
DROP PROCEDURE IF EXISTS BUSCAR_DEUDAS_ALUM;
DELIMITER $$
CREATE PROCEDURE BUSCAR_DEUDAS_ALUM(
    IN _familia_id INT,
    IN _id_tipo_deuda INT
)
BEGIN
    SELECT
        d.DEUDA_ID,   
        a.NOMBRE AS alumno_nombre,
        t.DESCRIPCION AS tipo_deuda,
        d.MONTO,
        d.FECHA_EMISION,
        d.FECHA_VENCIMIENTO,
        d.DESCRIPCION,
        d.DESCUENTO,
        d.ACTIVO,
        IFNULL(SUM(p.MONTO), 0) AS monto_pagado
    FROM RM_DEUDA d
    JOIN RM_ALUMNO a 
        ON a.ALUMNO_ID = d.ALUMNO_ID
    JOIN RM_TIPO_DEUDA t 
        ON t.ID_TIPO_DEUDA = d.ID_TIPO_DEUDA
    LEFT JOIN RM_PAGO p 
        ON p.DEUDA_ID = d.DEUDA_ID 
       AND p.ACTIVO = 1
    WHERE ( (_familia_id IS NULL OR _familia_id = 0) 
            OR a.FAMILIA_ID = _familia_id )
      AND ( (_id_tipo_deuda IS NULL OR _id_tipo_deuda = 0) 
            OR d.ID_TIPO_DEUDA = _id_tipo_deuda )
    GROUP BY 
        d.DEUDA_ID, a.NOMBRE, t.DESCRIPCION, 
        d.MONTO, d.FECHA_EMISION, d.FECHA_VENCIMIENTO,
        d.DESCRIPCION, d.DESCUENTO, d.ACTIVO;
END$$
DELIMITER ;



DROP PROCEDURE IF EXISTS CONSULTAR_DEUDA;
DELIMITER $$
CREATE PROCEDURE CONSULTAR_DEUDA(
    in _id_deuda int
)
BEGIN
    SELECT
        d.DEUDA_ID,   
        a.NOMBRE AS alumno_nombre,
        t.DESCRIPCION AS tipo_deuda,
        d.MONTO,
        d.FECHA_EMISION,
        d.FECHA_VENCIMIENTO,
        d.DESCUENTO,
	    (d.MONTO - d.DESCUENTO) AS monto_neto
    FROM RM_DEUDA d
    JOIN RM_ALUMNO a 
        ON a.ALUMNO_ID = d.ALUMNO_ID
    JOIN RM_TIPO_DEUDA t 
        ON t.ID_TIPO_DEUDA = d.ID_TIPO_DEUDA
    WHERE _id_deuda=d.DEUDA_ID;
END$$
DELIMITER ;

#ACTUALIZADO 16/11/2025:

DROP PROCEDURE IF EXISTS BUSCAR_PAGOS_DEUDA;
DELIMITER $$
CREATE PROCEDURE BUSCAR_PAGOS_DEUDA(
    in _id_deuda int
)
BEGIN
    SELECT
        pago_id
	from RM_PAGO
    WHERE _id_deuda=DEUDA_ID AND activo=1;
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS OBTENER_PAGO_POR_ID; -- PARA OBTENER LOS PAGOS ASOCIADOS A UNA DEUDA (INTERFAZ DE COBRANZA)
DELIMITER $$
CREATE PROCEDURE OBTENER_PAGO_POR_ID (
    IN _pago_id INT
)
BEGIN
	SELECT
		pago_id,
        medio,
        monto,
        observaciones,
        fecha,
        deuda_id
	from RM_PAGO
    where PAGO_ID=_pago_id;
END $$
DELIMITER ;

#==========================================================================================
#ACTUALIZADO 14/11/2025
DROP PROCEDURE IF EXISTS BUSCAR_GRADO_ACADEMICO_POR_NOMBRE_O_ABREVIATURA;
DELIMITER $$
CREATE PROCEDURE BUSCAR_GRADO_ACADEMICO_POR_NOMBRE_O_ABREVIATURA (
    IN _abreviatura VARCHAR(10),
	IN _nombre VARCHAR(45)
)
BEGIN
	SELECT
		grado_academico_id,
		nombre,
        abreviatura
	FROM RM_GRADO_ACADEMICO
    WHERE (_nombre IS NULL OR nombre LIKE CONCAT('%', _nombre, '%'))
  AND (_abreviatura IS NULL OR abreviatura LIKE CONCAT('%', _abreviatura, '%'))
  AND activo = 1;
END $$
DELIMITER ;
#==========================================================================================
#ACTUALIZADO 14/11/2025
DROP PROCEDURE IF EXISTS LISTAR_AULAS_POR_GRADO_ACADEMICO;
DELIMITER $$
CREATE PROCEDURE LISTAR_AULAS_POR_GRADO_ACADEMICO (
    IN _id_grado_academico INT
)
BEGIN
    SELECT
        a.ID_AULA,
        a.NOMBRE
    FROM RM_AULA a
    JOIN RM_GRADO_ACADEMICO g
        ON a.GRADO_ACADEMICO_ID = g.GRADO_ACADEMICO_ID
    WHERE a.ACTIVO = 1
      AND g.ACTIVO = 1
      AND a.GRADO_ACADEMICO_ID = _id_grado_academico;  
END $$
DELIMITER ;

#==========================================================================================
DROP PROCEDURE IF EXISTS BUSCAR_CURSO_POR_NOMBRE_ABREVIATURA_GRADO_ACADEMICO;
DELIMITER $$
CREATE PROCEDURE BUSCAR_CURSO_POR_NOMBRE_ABREVIATURA_GRADO_ACADEMICO (
	IN _nombre VARCHAR(45),
    IN _abreviatura VARCHAR(10),
    IN _nombre_grado VARCHAR(45)
)
BEGIN
	SELECT
		c.CURSO_ID,
        c.NOMBRE,
        c.ABREVIATURA,
        c.HORAS_SEMANALES,
        g.NOMBRE as NOMBRE_GRADO
	FROM RM_CURSO c
    JOIN RM_GRADO_ACADEMICO g ON g.GRADO_ACADEMICO_ID=c.GRADO_ACADEMICO_ID
    WHERE (c.NOMBRE LIKE CONCAT('%',_nombre,'%'))
		and (c.ABREVIATURA LIKE CONCAT('%',_abreviatura,'%'))
        and (g.NOMBRE LIKE CONCAT('%',_nombre_grado,'%'))
		and c.activo=1;
END $$
DELIMITER ;
#==========================================================================================
DROP PROCEDURE IF EXISTS BUSCAR_PERSONAL_POR_DNI_O_NOMBRE_APELLIDOS;
DELIMITER $$
CREATE PROCEDURE BUSCAR_PERSONAL_POR_DNI_O_NOMBRE_APELLIDOS(
    IN _dni INT,
    IN _nombre_apellidos VARCHAR(135)
)
BEGIN
    SELECT
		p.ID_PERSONAL,
        p.NOMBRE,
        p.APELLIDO_PATERNO,
        p.APELLIDO_MATERNO,
        p.DNI,
        c.NOMBRE AS NOMBRE_CARGO,
        p.CORREO_ELECTRONICO,
        p.TELEFONO,
        p.SALARIO,
        p.FECHA_CONTRATACION,
        p.FIN_FECHA_CONTRATO
	FROM RM_PERSONAL p, RM_CARGO c
	WHERE p.ID_CARGO = c.ID_CARGO AND p.ACTIVO=1
    AND ((_dni IS NULL OR CAST(p.DNI AS CHAR) LIKE CONCAT('%',CAST(_dni AS CHAR),'%') AND 
    CONCAT(p.NOMBRE,' ',p.APELLIDO_PATERNO,' ',p.APELLIDO_MATERNO) LIKE CONCAT('%',_nombre_apellidos,'%')));
END$$
DELIMITER ;
#==========================================================================================
#ACTUALIZADO 15/11/2026:
DROP PROCEDURE IF EXISTS BUSCAR_AULA_POR_NOMBRE_O_NOMBRE_GRADO;
DELIMITER $$
CREATE PROCEDURE BUSCAR_AULA_POR_NOMBRE_O_NOMBRE_GRADO(
    IN _nombre VARCHAR(45),
    IN _nombre_grado_academico VARCHAR(45)
)
BEGIN
    SELECT
        a.ID_AULA,
        a.NOMBRE,
        g.NOMBRE AS NOMBRE_GRADO
    FROM RM_AULA a
    JOIN RM_GRADO_ACADEMICO g
      ON a.GRADO_ACADEMICO_ID = g.GRADO_ACADEMICO_ID
    WHERE a.ACTIVO = 1
      AND g.ACTIVO = 1
      AND (_nombre IS NULL OR a.NOMBRE LIKE CONCAT('%', _nombre, '%'))
      AND (_nombre_grado_academico IS NULL OR g.NOMBRE LIKE CONCAT('%', _nombre_grado_academico, '%'));
END$$
DELIMITER ;

#==========================================================================================
DROP PROCEDURE IF EXISTS REGISTRAR_MATRICULA_CON_VACANTES;
DELIMITER $$

CREATE PROCEDURE REGISTRAR_MATRICULA_CON_VACANTES(
    IN _alumno_id INT,
    IN _aula_id INT
)
BEGIN
    DECLARE v_periodo_academico_id INT;
    DECLARE v_periodo_aula_id INT;
    DECLARE v_capacidad_total INT;
    DECLARE v_vac_ocup INT;
    DECLARE v_ya_existe INT DEFAULT 0;

    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error al registrar matrícula';
    END;

    START TRANSACTION;

    
    SELECT PERIODO_ACADEMICO_ID
      INTO v_periodo_academico_id
    FROM RM_PERIODO_ACADEMICO
    WHERE ACTIVO = 1
      AND YEAR(CURDATE()) BETWEEN YEAR(fecha_inicio) AND YEAR(fecha_fin)
    LIMIT 1;

    IF v_periodo_academico_id IS NULL THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No hay periodo académico vigente';
    END IF;

    SELECT PERIODO_AULA_ID,
           VACANTES_DISPONIBLES,                
           IFNULL(VACANTES_OCUPADAS, 0)         
      INTO v_periodo_aula_id, v_capacidad_total, v_vac_ocup
    FROM RM_PERIODOxAULA
    WHERE PERIODO_ACADEMICO_ID = v_periodo_academico_id
      AND ID_AULA = _aula_id
      AND ACTIVO = 1
    LIMIT 1;

    IF v_periodo_aula_id IS NULL THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El aula no está habilitada en el periodo vigente';
    END IF;

    
    IF v_vac_ocup >= v_capacidad_total THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No hay vacantes disponibles en el aula';
    END IF;

    
    SELECT COUNT(*)
      INTO v_ya_existe
    FROM RM_MATRICULA m
    JOIN RM_PERIODOxAULA pa ON pa.PERIODO_AULA_ID = m.PERIODO_AULA_ID
    WHERE m.ALUMNO_ID = _alumno_id
      AND pa.PERIODO_ACADEMICO_ID = v_periodo_academico_id
      AND m.ACTIVO = 1;

    IF v_ya_existe > 0 THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El alumno ya está matriculado en este periodo';
    END IF;

    INSERT INTO RM_MATRICULA(ALUMNO_ID, PERIODO_AULA_ID, ACTIVO)
    VALUES (_alumno_id, v_periodo_aula_id, 1);

    
    

    COMMIT;

    SELECT v_periodo_aula_id AS PERIODO_AULA_ID;
END$$

DELIMITER ;

#NUEVO CRUD ACTUALZIADO 23/11/2025

#==========================================================================================

#ACTUALIZADO 06/02/2026
DROP PROCEDURE IF EXISTS REGISTRAR_MATRICULA_CON_VACANTES;
DELIMITER $$
CREATE DEFINER=`admin`@`%` PROCEDURE `REGISTRAR_MATRICULA_CON_VACANTES`(
    IN _alumno_id INT,
    IN _aula_id INT,
    IN _costo_matricula DECIMAL(10,2),
    IN _costo_pension DECIMAL(10,2)
)
BEGIN
    DECLARE v_periodo_academico_id INT;
    DECLARE v_periodo_aula_id INT;
    DECLARE v_capacidad_total INT;
    DECLARE v_vac_ocup INT;
    DECLARE v_ya_existe INT DEFAULT 0;

    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error al registrar matrícula';
    END;

    START TRANSACTION;

    
    SELECT PERIODO_ACADEMICO_ID
      INTO v_periodo_academico_id
    FROM RM_PERIODO_ACADEMICO
    WHERE ACTIVO = 1
		AND YEAR(CURDATE()) BETWEEN YEAR(fecha_inicio) AND YEAR(fecha_fin)
    LIMIT 1;

    IF v_periodo_academico_id IS NULL THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No hay periodo académico vigente';
    END IF;

    SELECT PERIODO_AULA_ID,
           VACANTES_DISPONIBLES,                
           IFNULL(VACANTES_OCUPADAS, 0)         
      INTO v_periodo_aula_id, v_capacidad_total, v_vac_ocup
    FROM RM_PERIODOxAULA
    WHERE PERIODO_ACADEMICO_ID = v_periodo_academico_id
      AND ID_AULA = _aula_id
      AND ACTIVO = 1
    LIMIT 1;

    IF v_periodo_aula_id IS NULL THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El aula no está habilitada en el periodo vigente';
    END IF;

    
    IF v_vac_ocup >= v_capacidad_total THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No hay vacantes disponibles en el aula';
    END IF;

    
    SELECT COUNT(*)
      INTO v_ya_existe
    FROM RM_MATRICULA m
    JOIN RM_PERIODOxAULA pa ON pa.PERIODO_AULA_ID = m.PERIODO_AULA_ID
    WHERE m.ALUMNO_ID = _alumno_id
      AND pa.PERIODO_ACADEMICO_ID = v_periodo_academico_id
      AND m.ACTIVO = 1;

    IF v_ya_existe > 0 THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El alumno ya está matriculado en este periodo';
    END IF;

    INSERT INTO RM_MATRICULA(ALUMNO_ID, PERIODO_AULA_ID, ACTIVO, COSTO_MATRICULA, COSTO_PENSION)
    VALUES (_alumno_id, v_periodo_aula_id, 1, _costo_matricula, _costo_pension);

    
    

    COMMIT;

    SELECT v_periodo_aula_id AS PERIODO_AULA_ID;
END$$
DELIMITER ;

#==========================================================================================

DROP PROCEDURE IF EXISTS verificar_cuenta;
DELIMITER $$
CREATE PROCEDURE verificar_cuenta(
    IN p_nombre VARCHAR(50),
    IN p_hashclave VARCHAR(256)
)
BEGIN
    SELECT *
    FROM RM_USUARIO
    WHERE NOMBRE = p_nombre
      AND CLAVE_HASH = p_hashclave
      AND ACTIVO = 1
    LIMIT 1;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS obtener_salt_iteracion;
DELIMITER $$
CREATE PROCEDURE obtener_salt_iteracion(
    IN _nombre VARCHAR(50)
)
BEGIN
    SELECT SALT, ITERACION 
    FROM RM_USUARIO 
    WHERE NOMBRE = _nombre 
      AND ACTIVO = 1;
END $$
DELIMITER ;

DROP TRIGGER IF EXISTS TRG_BEFORE_INSERT_MATRICULA;
DELIMITER $$
CREATE TRIGGER TRG_BEFORE_INSERT_MATRICULA
BEFORE INSERT ON RM_MATRICULA
FOR EACH ROW
BEGIN
    DECLARE v_disp INT;
    DECLARE v_ocup INT;

    SELECT VACANTES_DISPONIBLES, VACANTES_OCUPADAS
    INTO v_disp, v_ocup
    FROM RM_PERIODOxAULA
    WHERE PERIODO_AULA_ID = NEW.PERIODO_AULA_ID;

    IF v_disp IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El PERIODO_AULA_ID no existe.';
    END IF;

    IF v_ocup >= v_disp THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Ya no hay vacantes disponibles para este periodo y aula.';
    END IF;

    UPDATE RM_PERIODOxAULA
    SET VACANTES_OCUPADAS = v_ocup + 1
    WHERE PERIODO_AULA_ID = NEW.PERIODO_AULA_ID;
END $$
DELIMITER ;

DROP TRIGGER IF EXISTS TRG_AFTER_INSERT_AULA;
DELIMITER $$
CREATE TRIGGER TRG_AFTER_INSERT_AULA
AFTER INSERT ON RM_AULA
FOR EACH ROW
BEGIN
    DECLARE v_periodo INT;

    SELECT PERIODO_ACADEMICO_ID
    INTO v_periodo
    FROM RM_PERIODO_ACADEMICO
    WHERE ACTIVO = 1
    ORDER BY FECHA_INICIO DESC
    LIMIT 1;

    IF v_periodo IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No existe un periodo académico activo para asignar al aula.';
    END IF;

    INSERT INTO RM_PERIODOxAULA
    (
        PERIODO_ACADEMICO_ID,
        ID_AULA,
        VACANTES_DISPONIBLES,
        VACANTES_OCUPADAS,
        ACTIVO
    )
    VALUES
    (
        v_periodo,
        NEW.ID_AULA,
        30,
        0,
        1
    );
END $$
DELIMITER ;

DROP TRIGGER IF EXISTS TRG_AFTER_UPDATE_MATRICULA;
DELIMITER $$
CREATE TRIGGER TRG_AFTER_UPDATE_MATRICULA
AFTER UPDATE ON RM_MATRICULA
FOR EACH ROW
BEGIN
    DECLARE v_ocup INT;

    IF OLD.ACTIVO = 1 AND NEW.ACTIVO = 0 THEN

        SELECT VACANTES_OCUPADAS
        INTO v_ocup
        FROM RM_PERIODOxAULA
        WHERE PERIODO_AULA_ID = OLD.PERIODO_AULA_ID;

        IF v_ocup <= 0 THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Error: las vacantes ocupadas ya están en 0.';
        END IF;

        UPDATE RM_PERIODOxAULA
        SET VACANTES_OCUPADAS = v_ocup - 1
        WHERE PERIODO_AULA_ID = OLD.PERIODO_AULA_ID;

    END IF;
END $$
DELIMITER ;

DROP TRIGGER IF EXISTS TRG_AFTER_INSERT_PERIODO;
DELIMITER $$
CREATE TRIGGER TRG_AFTER_INSERT_PERIODO
AFTER INSERT ON RM_PERIODO_ACADEMICO
FOR EACH ROW
BEGIN
	INSERT INTO RM_PERIODOxAULA (PERIODO_ACADEMICO_ID, ID_AULA, VACANTES_DISPONIBLES, VACANTES_OCUPADAS, ACTIVO)
    SELECT NEW.PERIODO_ACADEMICO_ID, ID_AULA, 30, 0, 1
    FROM RM_AULA
    WHERE ACTIVO = 1;
END $$
DELIMITER ;

#==========================================================================================

CREATE PROCEDURE LISTAR_AULA_ASIGNAR_MATR()
BEGIN
	SELECT
		a.nombre as aula_nombre,
		g.nombre as grado_nombre,
		per.vacantes_disponibles,
		per.periodo_aula_id
	FROM RM_PERIODOxAULA per
		join RM_AULA a on a.ID_AULA=per.ID_AULA
		join RM_PERIODO_ACADEMICO p on p.PERIODO_ACADEMICO_ID=per.PERIODO_ACADEMICO_ID
		join RM_GRADO_ACADEMICO g on g.GRADO_ACADEMICO_ID=a.GRADO_ACADEMICO_ID
	WHERE per.activo=1 
		and p.activo=1 
		and g.activo=1 
		and a.activo=1;
END

#==========================================================================================

#ACTUALIZADO: 06/02/2026:

DROP TRIGGER IF EXISTS TRG_AFTER_INSERT_MATRICULA_DEUDA;
DELIMITER ¡¡

CREATE TRIGGER TRG_AFTER_INSERT_MATRICULA_DEUDA
AFTER INSERT ON RM_MATRICULA
FOR EACH ROW
BEGIN
	DECLARE v_id_tipo_deuda INT;
    DECLARE v_id_tipo_deuda_pension INT;
    DECLARE v_fecha_inicio DATE;
    DECLARE v_fecha_fin DATE;

	-- Obtener el tipo de deuda "MATRICULA"
	SELECT ID_TIPO_DEUDA
	INTO v_id_tipo_deuda
	FROM RM_TIPO_DEUDA
	WHERE DESCRIPCION = 'MATRICULA'
	AND ACTIVO = 1
	LIMIT 1;
    
	-- Obtener el tipo de deuda "PENSION"
	SELECT ID_TIPO_DEUDA
	INTO v_id_tipo_deuda_pension
	FROM RM_TIPO_DEUDA
	WHERE DESCRIPCION = 'PENSION'
	AND ACTIVO = 1
	LIMIT 1;

	IF v_id_tipo_deuda IS NULL THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'No existe un TIPO_DEUDA activo para MATRÍCULA.';
	END IF;

	-- Insertar deuda automáticamente
	INSERT INTO RM_DEUDA(
		MONTO,
		ID_TIPO_DEUDA,
		FECHA_EMISION,
		FECHA_VENCIMIENTO,
		DESCRIPCION,
		DESCUENTO,
		ALUMNO_ID,
		ACTIVO
	)
	VALUES (
		NEW.COSTO_MATRICULA,
		v_id_tipo_deuda,
		CURDATE(),
		LAST_DAY(CURDATE()),
		'Deuda de matrícula automatica',
		0,
		NEW.ALUMNO_ID,
		1
	);
    
    set v_fecha_inicio = STR_TO_DATE(CONCAT(YEAR(NOW()), '-03-01'), '%Y-%m-%d');
	set v_fecha_fin = STR_TO_DATE(CONCAT(YEAR(NOW()), '-12-01'), '%Y-%m-%d');

    WHILE v_fecha_inicio <= v_fecha_fin DO
		INSERT INTO RM_DEUDA(
			MONTO,
			ID_TIPO_DEUDA,
			FECHA_EMISION,
			FECHA_VENCIMIENTO,
			DESCRIPCION,
			DESCUENTO,
			ALUMNO_ID,
			ACTIVO
		)
		VALUES (
			NEW.COSTO_PENSION,
			v_id_tipo_deuda_pension,
			v_fecha_inicio,
			LAST_DAY(v_fecha_inicio),
			'Deuda de pensión automatica',
			0,
			NEW.ALUMNO_ID,
			1
		);

		SET v_fecha_inicio = DATE_ADD(v_fecha_inicio, INTERVAL 1 MONTH);
	END WHILE;
    
END¡¡
DELIMITER ;