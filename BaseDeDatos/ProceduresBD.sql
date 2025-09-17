#=========================CRUD DE FAMILIA=========================
DROP PROCEDURE IF EXISTS INSERTAR_FAMILIA;
DELIMITER $$
CREATE PROCEDURE INSERTAR_FAMILIA (
    OUT _familia_id INT,
    IN _apellido_paterno VARCHAR(45),
    IN _apellido_materno VARCHAR(45),
    IN _num_telf VARCHAR(12),
    IN _correo_electronico VARCHAR(45),
    IN _direccion VARCHAR(50)
)
BEGIN
    INSERT INTO RM_FAMILIA(
        apellido_paterno,
        apellido_materno,
        num_telf,
        correo_electronico,
        direccion,
        estado
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
    IN _direccion VARCHAR(50)
)
BEGIN
	UPDATE RM_FAMILIA SET apellido_paterno = _apellido_paterno, apellido_materno = _apellido_materno, num_telf = _num_telf, correo_electronico = _correo_electronico,
		direccion = _direccion WHERE familia_id = _familia_id AND estado = 1;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS ELIMINAR_FAMILIA;
DELIMITER $$
CREATE PROCEDURE ELIMINAR_FAMILIA (
    IN _familia_id INT
)
BEGIN
	UPDATE RM_FAMILIA SET estado = 0 WHERE familia_id = _familia_id;
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
		AND estado = 1;
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
    WHERE estado = 1
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
    IN _pension_base DECIMAL(10,0),
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
        estado
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
    IN _pension_base DECIMAL(10,0),
    IN _familia_id INT
)
BEGIN
	UPDATE RM_ALUMNO SET dni = _dni, nombre = _nombre, fecha_nacimiento = _fecha_nacimiento, fecha_ingreso = _fecha_ingreso, sexo = _sexo, religion = _religion,
		observaciones = _observaciones, pension_base = _pension_base, familia_id = _familia_id WHERE alumno_id = _alumno_id AND estado = 1;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS ELIMINAR_ALUMNO;
DELIMITER $$
CREATE PROCEDURE ELIMINAR_ALUMNO (
    IN _alumno_id INT
)
BEGIN
	UPDATE RM_ALUMNO SET estado = 0 WHERE alumno_id = _alumno_id;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS OBTENER_ALUMNO_POR_ID;
DELIMITER $$
CREATE PROCEDURE OBTENER_ALUMNO_POR_ID (
    IN _alumno_id INT
)
BEGIN
	SELECT
		alumno_id,
		dni,
		nombre,
		fecha_nacimiento,
		fecha_ingreso,
		sexo,
		religion,
		observaciones,
		pension_base,
		familia_id
	FROM RM_ALUMNO
    WHERE alumno_id = _alumno_id
		AND estado = 1;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS LISTAR_ALUMNOS;
DELIMITER $$
CREATE PROCEDURE LISTAR_ALUMNOS ()
BEGIN
	SELECT
		alumno_id,
		dni,
		nombre,
		fecha_nacimiento,
		fecha_ingreso,
		sexo,
		religion,
		observaciones,
		pension_base,
		familia_id
	FROM RM_ALUMNO
    WHERE estado = 1
    ORDER BY alumno_id;
END $$
DELIMITER ;

#=========================CRUD DE DEUDA=========================
DROP PROCEDURE IF EXISTS INSERTAR_DEUDA;
DELIMITER $$
CREATE PROCEDURE INSERTAR_DEUDA (
	OUT _deuda_id INT,
    IN _monto DECIMAL(10,0),
    IN _tipo_deuda ENUM('MATRICULA', 'PENSION', 'MATRICULA_EXTRAORDINARIA', 'MORA', 'EXCURSION', 'MULTA', 'SERVICIOS_ADICIONALES'),
    IN _fecha_emision DATETIME,
    IN _fecha_vencimiento DATETIME,
    IN _descripcion VARCHAR(70),
    IN _descuento DECIMAL(10,0),
    IN _alumno_id INT
)
BEGIN
    INSERT INTO RM_DEUDA(
        monto,
        tipo_deuda,
        fecha_emision,
        fecha_vencimiento,
        descripcion,
        descuento,
        alumno_id,
        estado
    ) VALUES (
        _monto,
        _tipo_deuda,
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
    IN _monto DECIMAL(10,0),
    IN _tipo_deuda ENUM('MATRICULA', 'PENSION', 'MATRICULA_EXTRAORDINARIA', 'MORA', 'EXCURSION', 'MULTA', 'SERVICIOS_ADICIONALES'),
    IN _fecha_emision DATETIME,
    IN _fecha_vencimiento DATETIME,
    IN _descripcion VARCHAR(70),
    IN _descuento DECIMAL(10,0),
    IN _alumno_id INT
)
BEGIN
	UPDATE RM_DEUDA SET monto = _monto, tipo_deuda = _tipo_deuda, fecha_emision = _fecha_emision, fecha_vencimiento = _fecha_vencimiento,
	descripcion = _descripcion, descuento = _descuento, alumno_id = _alumno_id WHERE deuda_id = _deuda_id AND estado = 1;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS ELIMINAR_DEUDA;
DELIMITER $$
CREATE PROCEDURE ELIMINAR_DEUDA (
    IN _deuda_id INT
)
BEGIN
	UPDATE RM_DEUDA SET estado = 0 WHERE deuda_id = _deuda_id;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS OBTENER_DEUDA_POR_ID;
DELIMITER $$
CREATE PROCEDURE OBTENER_DEUDA_POR_ID (
    IN _deuda_id INT
)
BEGIN
	SELECT
		deuda_id,
		monto,
		tipo_deuda,
		fecha_emision,
		fecha_vencimiento,
		descripcion,
		descuento,
		alumno_id
	FROM RM_DEUDA
    WHERE deuda_id = _deuda_id
		AND estado = 1;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS LISTAR_DEUDAS;
DELIMITER $$
CREATE PROCEDURE LISTAR_DEUDAS ()
BEGIN
	SELECT
		deuda_id,
		monto,
		tipo_deuda,
		fecha_emision,
		fecha_vencimiento,
		descripcion,
		descuento,
		alumno_id
	FROM RM_DEUDA
    WHERE estado = 1
    ORDER BY deuda_id;
END $$
DELIMITER ;

#=========================CRUD DE PAGO=========================
DROP PROCEDURE IF EXISTS INSERTAR_PAGO;
DELIMITER $$
CREATE PROCEDURE INSERTAR_PAGO (
	OUT _pago_id INT,
    IN _monto DECIMAL(10,0),
    IN _fecha DATETIME,
    IN _medio ENUM('EFECTIVO', 'TARJETA', 'TRANSFERENCIA', 'DEPOSITO'),
    IN _observaciones VARCHAR(60),
    IN _deuda_id INT
)
BEGIN
    INSERT INTO RM_PAGO(
        monto,
        fecha,
        medio,
        observaciones,
        deuda_id,
        estado
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
    IN _monto DECIMAL(10,0),
    IN _fecha DATETIME,
    IN _medio ENUM('EFECTIVO', 'TARJETA', 'TRANSFERENCIA', 'DEPOSITO'),
    IN _observaciones VARCHAR(60),
    IN _deuda_id INT
)
BEGIN
	UPDATE RM_PAGO SET monto = _monto, fecha = _fecha, medio = _medio, observaciones = _observaciones, deuda_id = _deuda_id
    WHERE pago_id = _pago_id AND estado = 1;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS ELIMINAR_PAGO;
DELIMITER $$
CREATE PROCEDURE ELIMINAR_PAGO (
    IN _pago_id INT
)
BEGIN
	UPDATE RM_PAGO SET estado = 0 WHERE pago_id = _pago_id;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS OBTENER_PAGO_POR_ID;
DELIMITER $$
CREATE PROCEDURE OBTENER_PAGO_POR_ID (
    IN _pago_id INT
)
BEGIN
	SELECT
		pago_id,
		monto,
		fecha,
		medio,
		observaciones,
		deuda_id
	FROM RM_PAGO
    WHERE pago_id = _pago_id
		AND estado = 1;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS LISTAR_PAGOS;
DELIMITER $$
CREATE PROCEDURE LISTAR_PAGOS ()
BEGIN
	SELECT
		pago_id,
		monto,
		fecha,
		medio,
		observaciones,
		deuda_id
	FROM RM_PAGO
    WHERE estado = 1
    ORDER BY pago_id;
END $$
DELIMITER ;

#=========================CRUD DE USUARIO =========================
#Este CRUD se puede usar para agregar usuarios de cualquier tipo, pero por ahora se usara para insertar profesores
DROP PROCEDURE IF EXISTS INSERTAR_USUARIO;
DELIMITER $$
CREATE PROCEDURE INSERTAR_USUARIO (
	OUT _usuario_id INT,
    IN _clave VARCHAR(32),
    IN _nombre VARCHAR(45),
    IN _apellido_paterno VARCHAR(45),
    IN _apellido_materno VARCHAR(45),
    IN _email VARCHAR(45),
    IN _ultimo_acceso DATETIME,
    IN _rol_id INT
)
BEGIN
    INSERT INTO RM_USUARIO(
        clave,
        nombre,
        apellido_paterno,
        apellido_materno,
        email,
        ultimo_acceso,
        rol_id,
        estado
    ) VALUES (
        md5(_clave),
        _nombre,
        _apellido_paterno,
        _apellido_materno,
        _email,
        _ultimo_acceso,
        _rol_id,
        1
    );
    SET _usuario_id = @@last_insert_id;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS MODIFICAR_USUARIO;
DELIMITER $$
CREATE PROCEDURE MODIFICAR_USUARIO (
    IN _usuario_id INT,
    IN _clave VARCHAR(32),
    IN _nombre VARCHAR(45),
    IN _apellido_paterno VARCHAR(45),
    IN _apellido_materno VARCHAR(45),
    IN _email VARCHAR(45),
    IN _ultimo_acceso DATETIME,
    IN _rol_id INT
)
BEGIN
	UPDATE RM_USUARIO SET clave = md5(_clave), nombre = _nombre, apellido_paterno = _apellido_paterno, apellido_materno = _apellido_materno, email = _email,
    ultimo_acceso = _ultimo_acceso, rol_id = _rol_id
    WHERE usuario_id = _usuario_id AND estado = 1;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS ELIMINAR_USUARIO;
DELIMITER $$
CREATE PROCEDURE ELIMINAR_USUARIO (
    IN _usuario_id INT
)
BEGIN
	UPDATE RM_USUARIO SET estado = 0 WHERE usuario_id = _usuario_id;
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
		clave,
		nombre,
		apellido_paterno,
		apellido_materno,
		email,
		ultimo_acceso,
		rol_id
	FROM RM_USUARIO
    WHERE usuario_id = _usuario_id
		AND estado = 1;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS LISTAR_USUARIOS;
DELIMITER $$
CREATE PROCEDURE LISTAR_USUARIOS ()
BEGIN
	SELECT
		usuario_id,
		clave,
		nombre,
		apellido_paterno,
		apellido_materno,
		email,
		ultimo_acceso,
		rol_id
	FROM RM_USUARIO
    WHERE estado = 1
    ORDER BY usuario_id;
END $$
DELIMITER ;

#=========================MATRICULA=========================
 
DROP PROCEDURE IF EXISTS INSERTAR_MATRICULA;
DELIMITER $$
CREATE PROCEDURE INSERTAR_MATRICULA(
  OUT _matricula_id INT,
  IN  _alumno_id INT,
  IN  _grado_academico_id INT,
  IN  _periodo_academico_id INT
)
BEGIN
  IF NOT EXISTS (SELECT 1 FROM RM_ALUMNO WHERE ALUMNO_ID=_alumno_id AND ESTADO=1) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='ALUMNO_ID no existe o está inactivo';
  END IF;

  IF NOT EXISTS (SELECT 1 FROM RM_GRADO_ACADEMICO WHERE GRADO_ACADEMICO_ID=_grado_academico_id AND ESTADO=1) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='GRADO_ACADEMICO_ID no existe o está inactivo';
  END IF;

  IF NOT EXISTS (SELECT 1 FROM RM_PERIODO_ACADEMICO WHERE PERIODO_ACADEMICO_ID=_periodo_academico_id) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='PERIODO_ACADEMICO_ID no existe';
  END IF;
  
  INSERT INTO RM_MATRICULA(ALUMNO_ID, GRADO_ACADEMICO_ID, PERIODO_ACADEMICO_ID, ESTADO)
  VALUES (_alumno_id, _grado_academico_id, _periodo_academico_id, 1);

  SET _matricula_id = LAST_INSERT_ID();
END $$
DELIMITER ;
 
 
SELECT * FROM RM_MATRICULA;

 
DROP PROCEDURE IF EXISTS MODIFICAR_MATRICULA;
DELIMITER $$
CREATE PROCEDURE MODIFICAR_MATRICULA(
  IN _matricula_id INT,
  IN _alumno_id INT,
  IN _grado_academico_id INT,
  IN _periodo_academico_id INT
)
BEGIN
  IF NOT EXISTS (SELECT 1 FROM RM_MATRICULA WHERE MATRICULA_ID=_matricula_id) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='No existe el MATRICULA_ID indicado';
  END IF;
  -- Validar FKs
  IF NOT EXISTS (SELECT 1 FROM RM_ALUMNO WHERE ALUMNO_ID=_alumno_id AND ESTADO=1) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='ALUMNO_ID no existe o está inactivo';
  END IF;
  IF NOT EXISTS (SELECT 1 FROM RM_GRADO_ACADEMICO WHERE GRADO_ACADEMICO_ID=_grado_academico_id AND ESTADO=1) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='GRADO_ACADEMICO_ID no existe o está inactivo';
  END IF;
  IF NOT EXISTS (SELECT 1 FROM RM_PERIODO_ACADEMICO WHERE PERIODO_ACADEMICO_ID=_periodo_academico_id) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='PERIODO_ACADEMICO_ID no existe';
  END IF;
UPDATE RM_MATRICULA
     SET ALUMNO_ID=_alumno_id,
         GRADO_ACADEMICO_ID=_grado_academico_id,
         PERIODO_ACADEMICO_ID=_periodo_academico_id
   WHERE MATRICULA_ID=_matricula_id;
END $$
DELIMITER ;
 

 
SELECT * FROM RM_MATRICULA;
 
DROP PROCEDURE IF EXISTS OBTENER_MATRICULA_POR_ID;
DELIMITER $$
CREATE PROCEDURE OBTENER_MATRICULA_POR_ID(IN _matricula_id INT)
BEGIN
  SELECT m.MATRICULA_ID,
         m.ALUMNO_ID,
         m.GRADO_ACADEMICO_ID, g.NOMBRE  AS GRADO,
         m.PERIODO_ACADEMICO_ID, p.NOMBRE AS PERIODO,
         m.ESTADO
    FROM RM_MATRICULA m
    JOIN RM_GRADO_ACADEMICO g ON g.GRADO_ACADEMICO_ID=m.GRADO_ACADEMICO_ID
    JOIN RM_PERIODO_ACADEMICO p ON p.PERIODO_ACADEMICO_ID=m.PERIODO_ACADEMICO_ID
   WHERE m.MATRICULA_ID=_matricula_id;
END $$
DELIMITER ;

 
 


 
DROP PROCEDURE IF EXISTS LISTAR_MATRICULAS;
DELIMITER $$
CREATE PROCEDURE LISTAR_MATRICULAS()
BEGIN
  SELECT m.MATRICULA_ID,
         m.ALUMNO_ID,
         m.GRADO_ACADEMICO_ID, g.NOMBRE  AS GRADO,
         m.PERIODO_ACADEMICO_ID, p.NOMBRE AS PERIODO,
         m.ESTADO
    FROM RM_MATRICULA m
    JOIN RM_GRADO_ACADEMICO g ON g.GRADO_ACADEMICO_ID=m.GRADO_ACADEMICO_ID
    JOIN RM_PERIODO_ACADEMICO p ON p.PERIODO_ACADEMICO_ID=m.PERIODO_ACADEMICO_ID
   WHERE m.ESTADO=1
   ORDER BY p.FECHA_INICIO DESC, g.NOMBRE, m.ALUMNO_ID;
END $$
DELIMITER ;
 
 
 
DROP PROCEDURE IF EXISTS ELIMINAR_MATRICULA;
DELIMITER $$
CREATE PROCEDURE ELIMINAR_MATRICULA(IN _matricula_id INT)
BEGIN
  UPDATE RM_MATRICULA SET ESTADO=0
   WHERE MATRICULA_ID=_matricula_id;
END $$
DELIMITER ;
 
 
SELECT * FROM RM_MATRICULA;

#=========================CRUD DE GRADO_ACADÉMICO=========================
 
DROP PROCEDURE IF EXISTS INSERTAR_GRADO_ACADEMICO;
DELIMITER $$
CREATE PROCEDURE INSERTAR_GRADO_ACADEMICO(
  OUT _grado_academico_id INT,
  IN  _nombre VARCHAR(45),
  IN  _abreviatura VARCHAR(45)
)
BEGIN
  -- Normaliza entradas
  SET _nombre = TRIM(_nombre);
  SET _abreviatura = TRIM(_abreviatura);
  
   INSERT INTO RM_GRADO_ACADEMICO (NOMBRE, ABREVIATURA, ESTADO)
  VALUES (_nombre, _abreviatura, 1);

  SET _grado_academico_id = LAST_INSERT_ID();
END $$
DELIMITER ;
 
 
 
SELECT * FROM RM_GRADO_ACADEMICO;


 
DROP PROCEDURE IF EXISTS MODIFICAR_GRADO_ACADEMICO;
DELIMITER $$
CREATE PROCEDURE MODIFICAR_GRADO_ACADEMICO(
  IN _grado_academico_id INT,
  IN _nombre VARCHAR(45),
  IN _abreviatura VARCHAR(45)
)
BEGIN
  SET _nombre = TRIM(_nombre);
  SET _abreviatura = TRIM(_abreviatura);
UPDATE RM_GRADO_ACADEMICO
  SET NOMBRE = _nombre,
      ABREVIATURA = _abreviatura
  WHERE GRADO_ACADEMICO_ID = _grado_academico_id;
END $$
DELIMITER ;
 
 


 

DROP PROCEDURE IF EXISTS OBTENER_GRADO_ACADEMICO_POR_ID;
DELIMITER $$
CREATE PROCEDURE OBTENER_GRADO_ACADEMICO_POR_ID(
  IN _grado_academico_id INT
)
BEGIN
  SELECT GRADO_ACADEMICO_ID, NOMBRE, ABREVIATURA, ESTADO
  FROM RM_GRADO_ACADEMICO
  WHERE GRADO_ACADEMICO_ID = _grado_academico_id AND ESTADO = 1;
END $$
DELIMITER ;

 

 

DROP PROCEDURE IF EXISTS ELIMINAR_GRADO_ACADEMICO;
DELIMITER $$
CREATE PROCEDURE ELIMINAR_GRADO_ACADEMICO(
  IN _grado_academico_id INT
)
BEGIN

  IF EXISTS (
      SELECT 1 FROM RM_CURSO
      WHERE GRADO_ACADEMICO_ID = _grado_academico_id AND ACTIVO = 1
  ) THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'No se puede dar de baja: hay CURSOS activos en este grado';
  END IF;

  
  IF EXISTS (
      SELECT 1 FROM RM_MATRICULA
      WHERE GRADO_ACADEMICO_ID = _grado_academico_id AND ESTADO = 1
  ) THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'No se puede dar de baja: hay MATRÍCULAS activas en este grado';
  END IF;

  UPDATE RM_GRADO_ACADEMICO
  SET ESTADO = 0
  WHERE GRADO_ACADEMICO_ID = _grado_academico_id;
END $$
DELIMITER ;


 
DROP PROCEDURE IF EXISTS LISTAR_GRADOS_ACADEMICOS;
DELIMITER $$
CREATE PROCEDURE LISTAR_GRADOS_ACADEMICOS()
BEGIN
  SELECT GRADO_ACADEMICO_ID, NOMBRE, ABREVIATURA, ESTADO
  FROM RM_GRADO_ACADEMICO
  WHERE ESTADO = 1
  ORDER BY NOMBRE;
END $$
DELIMITER ;

 

#=========================CRUD DE CURSO=========================
 
DROP PROCEDURE IF EXISTS INSERTAR_CURSO;
DELIMITER $$
CREATE PROCEDURE INSERTAR_CURSO (
    OUT _curso_id INT,
    IN  _nombre VARCHAR(45),
    IN  _descripcion VARCHAR(45),
    IN  _horas INT,
    IN  _abreviatura VARCHAR(45),
    IN  _grado_academico_id INT
)
BEGIN
    SET _nombre = TRIM(_nombre);
    SET _descripcion = TRIM(_descripcion);
    SET _abreviatura = TRIM(_abreviatura);
    
     INSERT INTO RM_CURSO (NOMBRE, DESCRIPCION, HORAS_SEMANALAES, ACTIVO, ABREVIATURA, GRADO_ACADEMICO_ID)
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
    IN _descripcion VARCHAR(45),
    IN _horas INT,
    IN _abreviatura VARCHAR(45),
    IN _grado_academico_id INT,
    IN _activo TINYINT
)
BEGIN
    SET _nombre = TRIM(_nombre);
    SET _descripcion = TRIM(_descripcion);
    SET _abreviatura = TRIM(_abreviatura);


    IF NOT EXISTS (SELECT 1 FROM RM_CURSO WHERE CURSO_ID = _curso_id) THEN
        SIGNAL SQLSTATE '45000'
          SET MESSAGE_TEXT = 'No existe el CURSO_ID indicado';
    END IF;


    IF NOT EXISTS (SELECT 1 FROM RM_GRADO_ACADEMICO 
                   WHERE GRADO_ACADEMICO_ID = _grado_academico_id AND ESTADO = 1) THEN
        SIGNAL SQLSTATE '45000'
          SET MESSAGE_TEXT = 'No existe un GRADO_ACADEMICO activo con ese ID';
    END IF;
     UPDATE RM_CURSO
       SET NOMBRE = _nombre,
           DESCRIPCION = _descripcion,
           HORAS_SEMANALAES = _horas,
           ABREVIATURA = _abreviatura,
           GRADO_ACADEMICO_ID = _grado_academico_id,
           ACTIVO = _activo
     WHERE CURSO_ID = _curso_id;
END $$
DELIMITER ;

 
 
SELECT * FROM RM_CURSO;


DROP PROCEDURE IF EXISTS OBTENER_CURSO_POR_ID;
DELIMITER $$
CREATE PROCEDURE OBTENER_CURSO_POR_ID (IN _curso_id INT)
BEGIN
    SELECT CURSO_ID, NOMBRE, DESCRIPCION, HORAS_SEMANALAES, ABREVIATURA, GRADO_ACADEMICO_ID, ACTIVO
      FROM RM_CURSO
     WHERE CURSO_ID = _curso_id AND ACTIVO = 1;
END $$
DELIMITER ;
 
 
 
DROP PROCEDURE IF EXISTS ELIMINAR_CURSO;
DELIMITER $$
CREATE PROCEDURE ELIMINAR_CURSO (IN _curso_id INT)
BEGIN
    UPDATE RM_CURSO SET ACTIVO = 0 WHERE CURSO_ID = _curso_id;
END $$
DELIMITER ;

 
 
 
DROP PROCEDURE IF EXISTS LISTAR_CURSOS;
DELIMITER $$
CREATE PROCEDURE LISTAR_CURSOS()
BEGIN
    SELECT CURSO_ID, NOMBRE, DESCRIPCION, HORAS_SEMANALAES, ABREVIATURA, GRADO_ACADEMICO_ID, ACTIVO
      FROM RM_CURSO
     WHERE ACTIVO = 1
     ORDER BY GRADO_ACADEMICO_ID, NOMBRE;
END $$
DELIMITER ;

 
 


#=========================PERIODO ACADEMICO=========================

 
DROP PROCEDURE IF EXISTS INSERTAR_PERIODO_ACADEMICO;
DELIMITER $$
CREATE PROCEDURE INSERTAR_PERIODO_ACADEMICO(
  OUT _periodo_academico_id INT,
  IN  _nombre        VARCHAR(45),
  IN  _descripcion   VARCHAR(45),
  IN  _fecha_inicio  DATE,
  IN  _fecha_fin     DATE
)
BEGIN
  SET _nombre = TRIM(_nombre);
  SET _descripcion = TRIM(_descripcion);

  -- 1) Validaciones básicas
  IF _fecha_fin <= _fecha_inicio THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'FECHA_FIN debe ser mayor a FECHA_INICIO';
  END IF;
  
  INSERT INTO RM_PERIODO_ACADEMICO(NOMBRE, DESCRIPCION, FECHA_INICIO, FECHA_FIN, VIGENCIA)
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
  IN _descripcion   VARCHAR(45),
  IN _fecha_inicio  DATE,
  IN _fecha_fin     DATE
)
BEGIN
  SET _nombre = TRIM(_nombre);
  SET _descripcion = TRIM(_descripcion);

  IF NOT EXISTS (SELECT 1 FROM RM_PERIODO_ACADEMICO WHERE PERIODO_ACADEMICO_ID = _periodo_academico_id) THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'No existe el PERIODO_ACADEMICO_ID indicado';
  END IF;

  IF _fecha_fin <= _fecha_inicio THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'FECHA_FIN debe ser mayor a FECHA_INICIO';
  END IF;
UPDATE RM_PERIODO_ACADEMICO
     SET NOMBRE       = _nombre,
         DESCRIPCION  = _descripcion,
         FECHA_INICIO = _fecha_inicio,
         FECHA_FIN    = _fecha_fin
   WHERE PERIODO_ACADEMICO_ID = _periodo_academico_id;
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
  SELECT PERIODO_ACADEMICO_ID, NOMBRE, DESCRIPCION, FECHA_INICIO, FECHA_FIN, VIGENCIA
    FROM RM_PERIODO_ACADEMICO
   ORDER BY FECHA_INICIO DESC;
END $$
DELIMITER ;


DROP PROCEDURE IF EXISTS LISTAR_PERIODOS_VIGENTES;
DELIMITER $$
CREATE PROCEDURE LISTAR_PERIODOS_VIGENTES()
BEGIN
  SELECT PERIODO_ACADEMICO_ID, NOMBRE, DESCRIPCION, FECHA_INICIO, FECHA_FIN, VIGENCIA
    FROM RM_PERIODO_ACADEMICO
   WHERE VIGENCIA = 1
   ORDER BY FECHA_INICIO DESC;
END $$
DELIMITER ;

 
 
 

 
DROP PROCEDURE IF EXISTS ELIMINAR_PERIODO_ACADEMICO;
DELIMITER $$
CREATE PROCEDURE ELIMINAR_PERIODO_ACADEMICO(
  IN _periodo_academico_id INT
)
BEGIN
  IF EXISTS (
      SELECT 1 FROM RM_MATRICULA
       WHERE PERIODO_ACADEMICO_ID = _periodo_academico_id
         AND ESTADO = 1
  ) THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'No se puede dar de baja: existen MATRÍCULAS activas en este periodo';
  END IF;

  IF EXISTS (
      SELECT 1 FROM RM_VACANTES_GRADO
       WHERE PERIODO_ACADEMICO_ID = _periodo_academico_id
         AND ESTADO = 1
  ) THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'No se puede dar de baja: existen VACANTES DE GRADO activas en este periodo';
  END IF;

  UPDATE RM_PERIODO_ACADEMICO
     SET VIGENCIA = 0
   WHERE PERIODO_ACADEMICO_ID = _periodo_academico_id;
END $$
DELIMITER ;
 
 

#=========================VACANTES_AULA=========================
 
DROP PROCEDURE IF EXISTS INSERTAR_VACANTES_AULA;
DELIMITER $$
CREATE PROCEDURE INSERTAR_VACANTES_AULA(
  OUT _aula_id INT,
  IN  _nombre VARCHAR(45),
  IN  _vac_disponibles INT,
  IN  _vac_ocupadas INT
)
BEGIN

IF _vac_disponibles < 0 OR _vac_ocupadas < 0 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Las vacantes no pueden ser negativas';
  END IF;
  INSERT INTO RM_VACANTES_AULA (NOMBRE, VACANTES_DISPONIBLES, VACANTES_OCUPADAS, ESTADO)
  VALUES (_nombre, _vac_disponibles, _vac_ocupadas, 1);

  SET _aula_id = LAST_INSERT_ID();
END $$
DELIMITER ;
 
 
 
SELECT * FROM RM_VACANTES_AULA;

 
DROP PROCEDURE IF EXISTS MODIFICAR_VACANTES_AULA;
DELIMITER $$
CREATE PROCEDURE MODIFICAR_VACANTES_AULA(
  IN _aula_id INT,
  IN _nombre VARCHAR(45),
  IN _vac_disponibles INT,
  IN _vac_ocupadas INT
)
BEGIN
SET _nombre = TRIM(_nombre);
  IF NOT EXISTS (SELECT 1 FROM RM_VACANTES_AULA WHERE AULA_ID=_aula_id) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='No existe el AULA_ID indicado';
  END IF;
  IF _vac_disponibles < 0 OR _vac_ocupadas < 0 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Las vacantes no pueden ser negativas';
  END IF;
UPDATE RM_VACANTES_AULA
     SET NOMBRE=_nombre,
         VACANTES_DISPONIBLES=_vac_disponibles,
         VACANTES_OCUPADAS=_vac_ocupadas

   WHERE AULA_ID=_aula_id;
END $$
DELIMITER ;
 
 
SELECT * FROM RM_VACANTES_AULA;

 
DROP PROCEDURE IF EXISTS OBTENER_AULA_POR_ID;
DELIMITER $$
CREATE PROCEDURE OBTENER_AULA_POR_ID(IN _aula_id INT)
BEGIN
  SELECT AULA_ID, NOMBRE, VACANTES_DISPONIBLES, VACANTES_OCUPADAS, ESTADO
    FROM RM_VACANTES_AULA
   WHERE AULA_ID=_aula_id AND ESTADO=1;
END $$
DELIMITER ;
 
 
 
DROP PROCEDURE IF EXISTS LISTAR_AULAS;
DELIMITER $$
CREATE PROCEDURE LISTAR_AULAS()
BEGIN
  SELECT AULA_ID, NOMBRE, VACANTES_DISPONIBLES, VACANTES_OCUPADAS, ESTADO
    FROM RM_VACANTES_AULA
   WHERE ESTADO=1
   ORDER BY NOMBRE;
END $$
DELIMITER ;
 
 
 
DROP PROCEDURE IF EXISTS ELIMINAR_VACANTES_AULA;
DELIMITER $$
CREATE PROCEDURE ELIMINAR_VACANTES_AULA(
IN _aula_id INT)
BEGIN
UPDATE RM_VACANTES_AULA SET ESTADO=0 WHERE AULA_ID=_aula_id;
END $$
DELIMITER ;
 
 

