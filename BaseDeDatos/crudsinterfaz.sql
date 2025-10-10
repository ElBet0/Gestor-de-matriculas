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
DELIMITER ;
DROP PROCEDURE IF EXISTS OBTENER_HIJOS_FAMILIA;
DELIMITER $$
CREATE PROCEDURE OBTENER_HIJOS_FAMILIA (
    IN _familia_id INT	
)
BEGIN
	SELECT
		CONCAT(a.nombre, ' ', f.apellido_paterno) AS nombre_alumno,
        a.dni,
        a.sexo
	FROM RM_ALUMNO a
    JOIN RM_FAMILIA f ON f.familia_id=a.familia_id
    WHERE a.familia_id=_familia_id
		and a.activo=1 and f.activo=1;
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
        f.apellido_paterno,
        f.apellido_materno,
        a.sexo AS genero,
        a.nombre,
        CASE 
            WHEN a.pension_base = -1 THEN t.monto_general
            ELSE a.pension_base
        END AS pension
    FROM RM_ALUMNO a
    JOIN RM_FAMILIA f ON f.familia_id = a.familia_id
    LEFT JOIN RM_TIPO_DEUDA t ON t.descripcion = 'MATRICULA'
    WHERE (_apellido_paterno IS NULL OR f.apellido_paterno LIKE CONCAT('%',_apellido_paterno,'%'))
      AND (_apellido_materno IS NULL OR f.apellido_materno LIKE CONCAT('%',_apellido_materno,'%'))
      AND (_familia_id IS NULL OR a.familia_id =_familia_id)
      AND (_nombre IS NULL OR a.nombre LIKE CONCAT('%',_nombre,'%'))
      AND (_dni IS NULL OR a.dni LIKE CONCAT('%',_dni,'%'))
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
	IN _familia_id int,
    IN _apellido_paterno VARCHAR(45),
	in _apellido_materno VARCHAR(45),
	in _nombre varchar(45),
    in _dni int,
    in _ano int
)
BEGIN
	SELECT
		f.apellido_paterno,
        f.apellido_materno,
        a.sexo as genero,
        a.nombre,
        year(p.fecha_inicio) as anio,
        m.PERIODO_AULA_ID,
        a.ALUMNO_ID,
        a.FAMILIA_ID
	FROM RM_ALUMNO a 
    join RM_FAMILIA f on f.familia_id=a.familia_id
    join RM_MATRICULA m on m.alumno_id=a.alumno_id
    join RM_PERIODOxAULA per on per.PERIODO_AULA_ID=m.PERIODO_AULA_ID
    join RM_PERIODO_ACADEMICO p on p.PERIODO_ACADEMICO_ID=per.PERIODO_ACADEMICO_ID
    WHERE (_apellido_paterno IS NULL OR f.apellido_paterno LIKE CONCAT('%',_apellido_paterno,'%')) 
		and (_apellido_materno IS NULL OR f.apellido_materno LIKE CONCAT('%',_apellido_materno,'%')) 
        and (_familia_id IS NULL OR a.familia_id =_familia_id)
        and (_nombre IS NULL OR a.nombre LIKE CONCAT('%',_nombre,'%')) 
        and (_dni IS NULL OR a.dni LIKE CONCAT('%',_dni,'%')) 
		and year(p.fecha_inicio)=_ano;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS LISTAR_AULA_ASIGNAR_MATR;
DELIMITER $$
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
    WHERE per.activo=1 and p.activo=1 and g.activo=1 and a.activo=1;
END $$
DELIMITER ;
#================ CRUDS DE BUSQUEDA/CONSULTA PARA AREA COBRANZA ===============================

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
        d.DESCUENTO,
        IFNULL(SUM(p.MONTO), 0) AS monto_pagado
    FROM RM_DEUDA d
    JOIN RM_ALUMNO a 
        ON a.ALUMNO_ID = d.ALUMNO_ID
    JOIN RM_TIPO_DEUDA t 
        ON t.ID_TIPO_DEUDA = d.ID_TIPO_DEUDA
    LEFT JOIN RM_PAGO p 
        ON p.DEUDA_ID = d.DEUDA_ID AND p.activo = 1
    WHERE (_familia_id IS NULL OR a.FAMILIA_ID = _familia_id)
      AND (_id_tipo_deuda IS NULL OR d.ID_TIPO_DEUDA = _id_tipo_deuda)
    GROUP BY 
        d.DEUDA_ID, a.NOMBRE, t.DESCRIPCION, 
        d.MONTO, d.FECHA_EMISION, d.FECHA_VENCIMIENTO, d.DESCUENTO;
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


DROP PROCEDURE IF EXISTS BUSCAR_PAGOS_DEUDA;
DELIMITER $$
CREATE PROCEDURE BUSCAR_PAGOS_DEUDA(
    in _id_deuda int
)
BEGIN
    SELECT
        pago_id
	from RM_PAGO
    WHERE _id_deuda=DEUDA_ID;
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
    WHERE (nombre LIKE CONCAT('%',_nombre,'%'))
		and (abreviatura LIKE CONCAT('%',_abreviatura,'%'))
		and activo=1;
END $$
DELIMITER ;
#==========================================================================================
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
    JOIN RM_GRADO_ACADEMICO g ON a.GRADO_ACADEMICO_ID=g.GRADO_ACADEMICO_ID
    WHERE a.activo=1;
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
	WHERE p.ID_CARGO = c.ID_CARGO
    AND ((_dni IS NULL OR CAST(_dni AS CHAR) LIKE CONCAT('%',CAST(p.DNI AS CHAR),'%') OR 
    CONCAT(p.NOMBRE,' ',p.APELLIDO_PATERNO,' ',p.APELLIDO_MATERNO) LIKE CONCAT('%',_nombre_apellidos,'%')));
END$$
DELIMITER ;
#==========================================================================================
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
	FROM RM_AULA a, RM_GRADO_ACADEMICO g
	WHERE a.GRADO_ACADEMICO_ID = g.GRADO_ACADEMICO_ID
    AND ((a.NOMBRE LIKE CONCAT('%',_nombre,'%')) OR (g.NOMBRE LIKE CONCAT('%',_nombre_grado_academico,'%')));
END$$
DELIMITER ;
