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

DROP PROCEDURE IF EXISTS LISTAR_ALUMNOS;
DELIMITER $$
CREATE PROCEDURE LISTAR_ALUMNOS ()
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
    WHERE	a.activo = 1
		AND f.activo = 1
    ORDER BY alumno_id;
END $$
DELIMITER ;

#=========================CRUD DE DEUDA=========================
DROP PROCEDURE IF EXISTS INSERTAR_DEUDA;
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

DROP PROCEDURE IF EXISTS OBTENER_DEUDA_POR_ID;
DELIMITER $$
CREATE PROCEDURE OBTENER_DEUDA_POR_ID (
    IN _deuda_id INT
)
BEGIN
	SELECT
		d.deuda_id,
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
        a.observaciones,
        a.pension_base,
        a.familia_id,
		f.apellido_paterno,
        f.apellido_materno,
        f.num_telf,
        f.correo_electronico,
        f.direccion
	FROM RM_DEUDA d
    inner join RM_TIPO_DEUDA t on t.id_tipo_deuda=d.id_tipo_deuda
    INNER JOIN RM_ALUMNO a ON d.ALUMNO_ID=a.ALUMNO_ID
    INNER JOIN RM_FAMILIA f ON f.FAMILIA_ID=a.FAMILIA_ID
    WHERE d.deuda_id = _deuda_id
      AND d.activo = 1
      AND a.activo = 1
      AND f.activo = 1
      and t.activo=1;
END $$
DELIMITER ;
desc RM_DEUDA;
DROP PROCEDURE IF EXISTS LISTAR_DEUDAS;
DELIMITER $$
CREATE PROCEDURE LISTAR_DEUDAS ()
BEGIN
	SELECT
		d.ID_TIPO_DEUDA,
		d.deuda_id,
		d.monto,
		t.descripcion,
		t.monto_general,
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
        a.observaciones,
        a.pension_base,
        a.familia_id,
		f.apellido_paterno,
        f.apellido_materno,
        f.num_telf,
        f.correo_electronico,
        f.direccion
	FROM RM_DEUDA d
    inner join RM_TIPO_DEUDA t on t.id_tipo_deuda=d.id_tipo_deuda
    INNER JOIN RM_ALUMNO a ON d.ALUMNO_ID=a.ALUMNO_ID
    INNER JOIN RM_FAMILIA f ON f.FAMILIA_ID=a.FAMILIA_ID
    WHERE  d.activo = 1
      AND a.activo = 1
      AND f.activo = 1
    ORDER BY deuda_id;
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
 
 
SELECT * FROM RM_MATRICULA;

 
DROP PROCEDURE IF EXISTS MODIFICAR_MATRICULA;
DELIMITER $$
CREATE PROCEDURE MODIFICAR_MATRICULA(
  IN _matricula_id INT,
  IN _periodo_aula_id INT
)
BEGIN
  
UPDATE RM_MATRICULA
     SET _periodo_aula_id=periodo_aula_id
   WHERE MATRICULA_ID=_matricula_id and activo=1;
END $$
DELIMITER ;
 

 
SELECT * FROM RM_MATRICULA;
 
DROP PROCEDURE IF EXISTS OBTENER_MATRICULA_POR_ID;
DELIMITER $$
CREATE PROCEDURE OBTENER_MATRICULA_POR_ID(IN _matricula_id INT)
BEGIN
  SELECT 
         m.MATRICULA_ID,
         m.ALUMNO_ID,
         
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

    -- Verificar que la matrícula exista y esté activa
    SELECT COUNT(*) INTO v_count
    FROM RM_MATRICULA
    WHERE MATRICULA_ID = _matricula_id
      AND ACTIVO = 1;

    IF v_count = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La matrícula no existe o ya está desactivada.';
    ELSE
        -- Eliminación lógica
        UPDATE RM_MATRICULA 
        SET ACTIVO = 0 
        WHERE MATRICULA_ID = _matricula_id
        LIMIT 1;
    END IF;
END $$
DELIMITER ;
 
 
SELECT * FROM RM_MATRICULA;
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
  -- Normaliza entradas
  SET _nombre = TRIM(_nombre);
  SET _abreviatura = TRIM(_abreviatura);
  
   INSERT INTO RM_GRADO_ACADEMICO (NOMBRE, ABREVIATURA, ACTIVO)
  VALUES (_nombre, _abreviatura, 1);

  SET _grado_academico_id = LAST_INSERT_ID();
END $$
DELIMITER ;
 
 desc RM_GRADO_ACADEMICO;
 
SELECT * FROM RM_GRADO_ACADEMICO;


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

    -- Verificar matrículas activas ligadas al grado académico
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

    -- Verificar cursos activos ligados al grado
    SELECT COUNT(*) INTO v_count
    FROM RM_CURSO
    WHERE GRADO_ACADEMICO_ID = _grado_id
      AND ACTIVO = 1;
    IF v_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No se puede eliminar el grado académico porque tiene cursos activos asociados.';
    END IF;

    -- Si no hay dependencias activas, eliminar lógicamente el grado académico
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

 
 
SELECT * FROM RM_CURSO;

 
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

 
 
SELECT * FROM RM_CURSO;


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

 
 
 
SELECT * FROM RM_PERIODO_ACADEMICO;

 
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
  SELECT PERIODO_ACADEMICO_ID, NOMBRE, DESCRIPCION, FECHA_INICIO, FECHA_FIN, VIGENCIA
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

  -- Eliminar lógicamente el periodo
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

    -- Validar que no existan deudas activas asociadas
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
      AND ID_CARGO = _id_cargo
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

    -- Verificar si existen matrículas activas ligadas
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
    -- Verificar si existen filas de RM_PERIODOxAULA
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
#OBTENER AULA POR ID
DROP PROCEDURE IF EXISTS OBTENER_AULA_POR_ID;
DELIMITER $$
CREATE PROCEDURE OBTENER_AULA_POR_ID (
	IN _aula_id INT
)
BEGIN
	SELECT
		a.ID_AULA as AULA_ID,
        a.NOMBRE as NOMBRE_AULA,
        a.GRADO_ACADEMICO_ID,
        g.NOMBRE as NOMBRE_GRADO,
        g.ABREVIATURA as ABREVIATURA_GRADO
    FROM RM_AULA a, RM_GRADO_ACADEMICO g
    WHERE g.GRADO_ACADEMICO_ID = a.GRADO_ACADEMICO_ID AND a.id_aula = _aula_id AND a.ACTIVO = 1 AND g.ACTIVO = 1;
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