-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2019-10-12 01:08:13.693

-- tables
-- Table: CURSO
CREATE TABLE CURSO (
    CODCUR char(3) NOT NULL COMMENT 'Contiene el código único para cada curso ofertado.',
    DESCUR varchar(30) NULL COMMENT 'Descripción corta del curso.',
    CATCUR char(3) NULL COMMENT 'Categoría de curso (GEN = General, DEV = Desarrollo y ADS = Análisis y Diseño de Sistemas).',
    DURCUR int NULL COMMENT 'Duración del curso en número de días.',
    CONSTRAINT CURSO_pk PRIMARY KEY (CODCUR)
) COMMENT 'contiene toda la información referente a los cursos que se ofertan';

-- Table: DEPARTAMENTO
CREATE TABLE DEPARTAMENTO (
    IDDEP int NOT NULL COMMENT 'Identificador de cada departamento.',
    NOMDEP varchar(50) NULL COMMENT 'Nombre descriptivo de departamento.',
    CONSTRAINT DEPARTAMENTO_pk PRIMARY KEY (IDDEP)
) COMMENT 'contiene toda la información de los departamentos en los que trabajan los empleados.
';

-- Table: EMPLEADO
CREATE TABLE EMPLEADO (
    IDEMP int NOT NULL COMMENT 'Es el dato identificador de todo empleado.',
    FECINGEMP date NULL COMMENT 'Fecha de ingreso del empleado.',
    CARGEMP varchar(40) NULL COMMENT 'Descripción del cargo del empleado.',
    SALEMP decimal(6,2) NULL COMMENT 'Monto de salario del empleado (no incluye bonos).',
    ESTEMP int NULL COMMENT 'Determina si es A activo o I inactivo. Si está trabajando actualmente o no. Por default será A.',
    EMPLEADO_IDEMP int NOT NULL COMMENT 'Un empleado puede tener a su cargo 0, 1 ó muchos empleados.',
    DEPARTAMENTO_IDDEP int NOT NULL COMMENT 'Un departamento puede tener formado por 0, 1 ó muchos empleados.',
    NIVEL_SUELDO_NIVSUE int NOT NULL COMMENT 'Un nivel o grado de sueldo puede comprender 0, 1 o muchos montos de salarios de los empleados.',
    PERSONA_IDPER int NOT NULL COMMENT 'Una persona puede ser registrado como empleado ninguna, una o muchas veces.',
    CONSTRAINT EMPLEADO_pk PRIMARY KEY (IDEMP)
) COMMENT 'contiene la información necesaria del empleado.
';

-- Table: HISTORICO
CREATE TABLE HISTORICO (
    IDHIS int NOT NULL COMMENT 'Identificador de Histórico.',
    FECFINHIST date NULL COMMENT 'Fin de fecha de intervalo de trabajo, ya sea por despido o por cambios de cargo.',
    TIPHIS char(3) NULL COMMENT 'Tipo de Histórico: CAMB cambio de departamento ó FIN término de labores en la empresa.',
    COMEHIST varchar(100) NULL,
    EMPLEADO_IDEMP int NOT NULL COMMENT 'Un empleado puede ser ascendido o irse de la empresa ninguna, una o muchas veces.',
    CONSTRAINT HISTORICO_pk PRIMARY KEY (IDHIS)
) COMMENT 'contiene la información histórica de los años trabajados de un empleado dentro de la empresa';

-- Table: INSCRIPCION
CREATE TABLE INSCRIPCION (
    IDINSC int NOT NULL COMMENT 'Identificador de la inscripción realizada.',
    FECINS date NULL COMMENT 'Fecha en que se realiza la inscripción.',
    EVALINSC int NULL COMMENT 'Opinión sobre la persona que lo atendió (escala del 1 - 5)',
    EMPLEADO_IDEMP int NOT NULL COMMENT 'Un empleado del departamento de ventas puede realizar ninguna, una o muchas inscripciones ',
    PERSONA_IDPER int NOT NULL COMMENT 'Un persona de tipo de estudiante se puede registrar ninguna, una o muchas veces en los cursos.',
    OFERTA_IDOFER int NOT NULL COMMENT 'Una oferta de curso puede estar en 0, 1 o muchas veces inscripciones.',
    CONSTRAINT INSCRIPCION_pk PRIMARY KEY (IDINSC)
) COMMENT 'contiene todas las inscripciones realizadas a los cursos ofertados y que son atendidos por los empleados del departamento de ventas';

-- Table: NIVEL_SUELDO
CREATE TABLE NIVEL_SUELDO (
    NIVSUE int NOT NULL COMMENT 'Identificador del grado o nivel de venta que puede alcanzar el vendedor.',
    MONMINNIVSUE decimal(6,2) NULL COMMENT 'Monto mínimo de venta realizada.',
    MONMAXNIVSUE decimal(6,2) NULL COMMENT 'Monto máximo de venta realizada.',
    BONUSNIVSUE decimal(6,2) NULL COMMENT 'Bonificación neta adicional a su salario mensual.',
    CONSTRAINT NIVEL_SUELDO_pk PRIMARY KEY (NIVSUE)
) COMMENT ' contiene los niveles o grados de sueldo que puede alcanzar el empleado de acuerdo a su productividad.';

-- Table: OFERTA
CREATE TABLE OFERTA (
    IDOFER int NOT NULL COMMENT 'Identificador de oferta.',
    FECOFER date NULL COMMENT 'Fecha de inicio de oferta de curso.',
    FECINICCUROFER date NULL COMMENT 'Fecha de inicio de curso ofertado.',
    CURSO_CODCUR char(3) NOT NULL COMMENT 'Un curso puede estar presente en ninguna, una o muchas ofertas.',
    EMPLEADO_IDEMP int NOT NULL COMMENT 'Un profesor puede dictar ninguno, uno o más cursos.',
    CONSTRAINT OFERTA_pk PRIMARY KEY (IDOFER)
) COMMENT ' contiene las ofertas de cursos con su respectiva fecha de inicio y profesor.';

-- Table: PERSONA
CREATE TABLE PERSONA (
    IDPER int NOT NULL COMMENT 'Es el dato identificador de la persona',
    DNIPER char(8) NULL COMMENT 'Numero de DNI',
    NOMPER varchar(50) NULL COMMENT 'contiene los nombres de las personas',
    APEPER varchar(80) NOT NULL COMMENT 'contiene los apellidos de la persona',
    FECNACPER date NULL COMMENT 'Contiene la fecha de nacimiento de la persona.',
    CELPER char(9) NOT NULL COMMENT 'Contiene el númer de celular de la persona.',
    EMAPER varchar(100) NOT NULL COMMENT 'Contiene el correo electrónico de la persona.',
    SEXPER char(1) NULL COMMENT 'Contiene el identificador de sexo de la persona (M) Masculino y (F) para Femenino.',
    TIPER char(3) NULL COMMENT 'Determina si la persona es un EMP Empleado o un EST Estudiante.',
    DISTPER varchar(80) NOT NULL COMMENT 'Contiene el nombre del distrito de procedencia de la persona. Sólo se admite distritos de la provincia de Cañete.',
    CONSTRAINT PERSONA_pk PRIMARY KEY (IDPER)
) COMMENT 'contiene  los datos generales de toda persona,ademas especifica si es estudiante  o empleado';

-- foreign keys
-- Reference: EMPLEADO_DEPARTAMENTO (table: EMPLEADO)
ALTER TABLE EMPLEADO ADD CONSTRAINT EMPLEADO_DEPARTAMENTO FOREIGN KEY EMPLEADO_DEPARTAMENTO (DEPARTAMENTO_IDDEP)
    REFERENCES DEPARTAMENTO (IDDEP);

-- Reference: EMPLEADO_EMPLEADO (table: EMPLEADO)
ALTER TABLE EMPLEADO ADD CONSTRAINT EMPLEADO_EMPLEADO FOREIGN KEY EMPLEADO_EMPLEADO (EMPLEADO_IDEMP)
    REFERENCES EMPLEADO (IDEMP);

-- Reference: EMPLEADO_NIVEL_SUELDO (table: EMPLEADO)
ALTER TABLE EMPLEADO ADD CONSTRAINT EMPLEADO_NIVEL_SUELDO FOREIGN KEY EMPLEADO_NIVEL_SUELDO (NIVEL_SUELDO_NIVSUE)
    REFERENCES NIVEL_SUELDO (NIVSUE);

-- Reference: EMPLEADO_PERSONA (table: EMPLEADO)
ALTER TABLE EMPLEADO ADD CONSTRAINT EMPLEADO_PERSONA FOREIGN KEY EMPLEADO_PERSONA (PERSONA_IDPER)
    REFERENCES PERSONA (IDPER);

-- Reference: HISTORICO_EMPLEADO (table: HISTORICO)
ALTER TABLE HISTORICO ADD CONSTRAINT HISTORICO_EMPLEADO FOREIGN KEY HISTORICO_EMPLEADO (EMPLEADO_IDEMP)
    REFERENCES EMPLEADO (IDEMP);

-- Reference: INSCRIPCION_EMPLEADO (table: INSCRIPCION)
ALTER TABLE INSCRIPCION ADD CONSTRAINT INSCRIPCION_EMPLEADO FOREIGN KEY INSCRIPCION_EMPLEADO (EMPLEADO_IDEMP)
    REFERENCES EMPLEADO (IDEMP);

-- Reference: INSCRIPCION_OFERTA (table: INSCRIPCION)
ALTER TABLE INSCRIPCION ADD CONSTRAINT INSCRIPCION_OFERTA FOREIGN KEY INSCRIPCION_OFERTA (OFERTA_IDOFER)
    REFERENCES OFERTA (IDOFER);

-- Reference: INSCRIPCION_PERSONA (table: INSCRIPCION)
ALTER TABLE INSCRIPCION ADD CONSTRAINT INSCRIPCION_PERSONA FOREIGN KEY INSCRIPCION_PERSONA (PERSONA_IDPER)
    REFERENCES PERSONA (IDPER);

-- Reference: OFERTA_CURSO (table: OFERTA)
ALTER TABLE OFERTA ADD CONSTRAINT OFERTA_CURSO FOREIGN KEY OFERTA_CURSO (CURSO_CODCUR)
    REFERENCES CURSO (CODCUR);

-- Reference: OFERTA_EMPLEADO (table: OFERTA)
ALTER TABLE OFERTA ADD CONSTRAINT OFERTA_EMPLEADO FOREIGN KEY OFERTA_EMPLEADO (EMPLEADO_IDEMP)
    REFERENCES EMPLEADO (IDEMP);

-- End of file.

