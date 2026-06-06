/*create database club_ecologico_aragon;
use club_ecologico_aragon;*/

create table usuario (
    id_usuario   int          not null auto_increment,
    contrasenia  varchar(100) not null,
    rol          enum('recepcionista', 'socio', 'voluntario') not null,
    constraint pk_id_usuario  primary key (id_usuario),
    constraint uq_contrasenia unique (contrasenia)
);

create table recepcionista (
    id_recepcionista int not null,
    constraint pk_id_recepcionista primary key (id_recepcionista),
    constraint fk_id_recepcionista foreign key (id_recepcionista)
        references usuario (id_usuario)
);

create table direccion_socio (
    id_direccion_s int          not null auto_increment,
    colonia        varchar(100) not null,
    estado         varchar(60)  not null,
    cp             char(5)      not null,
    calle          varchar(150),
    constraint pk_id_direccion_s primary key (id_direccion_s)
);

create table socio (
    id_socio         int          not null,
    id_direccion_s   int          not null,
    nombre           varchar(100) not null,
    apellido_paterno varchar(100) not null,
    apellido_materno varchar(100) not null,
    fecha_nacimiento date         not null,
    curp             varchar(18),
    constraint pk_id_socio       primary key (id_socio),
    constraint fk_id_socio       foreign key (id_socio)
        references usuario (id_usuario),
    constraint fk_id_direccion_s foreign key (id_direccion_s)
        references direccion_socio (id_direccion_s)
);

create table telefono_socio (
    id_telefono_s   int      not null auto_increment,
    numero_telefono char(10) not null,
    constraint pk_id_telefono_s       primary key (id_telefono_s),
    constraint ck_numero_telefono_len check (char_length(numero_telefono) = 10)
);

create table registro_telefono_socio (
    id_telefono_s int not null,
    id_socio      int not null,
    constraint pk_registro_telefono_socio primary key (id_telefono_s, id_socio),
    constraint fk_telefono_socio          foreign key (id_telefono_s)
        references telefono_socio (id_telefono_s),
    constraint fk_rts_id_socio            foreign key (id_socio)
        references socio (id_socio)
);

create table actividad (
    id_actividad      int          not null auto_increment,
    nombre            varchar(100) not null,
    numero_asistentes int          not null default 0,
    fecha_inicio      date         not null,
    hora_inicio       time         not null,
    hora_termino      time         not null,
    encargado         varchar(100) not null,
    cupos             int          not null,
    constraint pk_id_actividad primary key (id_actividad),
    constraint ck_cupos        check (cupos > 0),
    constraint ck_hora_termino check (hora_termino > hora_inicio),
    constraint ck_asistentes   check (numero_asistentes >= 0)
);

create table entrada (
    id_folio_reservacion int not null auto_increment,
    id_socio             int not null,
    id_actividad         int not null,
    constraint pk_folio_reservacion primary key (id_folio_reservacion),
    constraint fk_entrada_socio     foreign key (id_socio)
        references socio (id_socio),
    constraint fk_entrada_actividad foreign key (id_actividad)
        references actividad (id_actividad)
);

create table necesidad (
    id_necesidad      int                           not null auto_increment,
    area              varchar(100)                  not null,
    descripcion       text                          not null,
    urgencia          enum('alta', 'media', 'baja') not null,
    numero_voluntario int                           not null,
    fecha_publicacion date                          default (current_date()),
    fecha_vencimiento date                          not null,
    constraint pk_id_necesidad      primary key (id_necesidad),
    constraint ck_numero_voluntario check (numero_voluntario > 0),
    constraint ck_fechas_necesidad  check (fecha_vencimiento > fecha_publicacion)
);

create table ficha (
    id_ficha         int not null auto_increment,
    id_recepcionista int not null,
    id_necesidad     int not null,
    constraint pk_id_ficha        primary key (id_ficha),
    constraint fk_ficha_recep     foreign key (id_recepcionista)
        references recepcionista (id_recepcionista),
    constraint fk_ficha_necesidad foreign key (id_necesidad)
        references necesidad (id_necesidad)
);

create table donativo (
    id_folio_donativo int            not null auto_increment,
    razon_social      varchar(200)   not null,
    monto             decimal(10, 2) not null,
    patrocinador      varchar(150),
    fecha_ingreso     date           default (current_date()),
    constraint pk_id_folio_donativo primary key (id_folio_donativo),
    constraint ck_monto             check (monto > 0)
);

create table informe (
    id_folio_informe  int not null auto_increment,
    id_folio_donativo int not null,
    id_recepcionista  int not null,
    constraint pk_folio_informe    primary key (id_folio_informe),
    constraint fk_informe_donativo foreign key (id_folio_donativo)
        references donativo (id_folio_donativo),
    constraint fk_informe_recep    foreign key (id_recepcionista)
        references recepcionista (id_recepcionista)
);

create table direccion_voluntario (
    id_direccion_v int          not null auto_increment,
    colonia        varchar(100) not null,
    estado         varchar(60)  not null,
    cp             char(5)      not null,
    calle          varchar(150) not null,
    constraint pk_direccion_voluntario primary key (id_direccion_v)
);

create table voluntario (
    id_voluntario      int          not null,
    id_direccion_v     int          not null,
    nombre             varchar(100) not null,
    apellido_paterno   varchar(100) not null,
    apellido_materno   varchar(100) not null,
    edad               int          not null,
    nss                char(11)     not null,
    fecha_nacimiento   date         not null,
    curp               varchar(18),
    descripcion        text,
    correo_electronico varchar(150),
    status_v           enum('pendiente', 'aprobado', 'rechazado') default 'pendiente',
    constraint pk_id_voluntario  primary key (id_voluntario),
    constraint fk_id_voluntario  foreign key (id_voluntario)
        references usuario (id_usuario),
    constraint fk_id_direccion_v foreign key (id_direccion_v)
        references direccion_voluntario (id_direccion_v)
);

create table telefono_voluntario (
    id_telefono_v   int      not null auto_increment,
    numero_telefono char(10) not null,
    constraint pk_telefono_voluntario primary key (id_telefono_v),
    constraint chk_tel_voluntario_len check (char_length(numero_telefono) = 10)
);

create table registro_telefono_voluntario (
    id_telefono_v int not null,
    id_voluntario int not null,
    constraint pk_registro_tel_voluntario primary key (id_telefono_v, id_voluntario),
    constraint fk_rtv_telefono            foreign key (id_telefono_v)
        references telefono_voluntario (id_telefono_v),
    constraint fk_rtv_voluntario          foreign key (id_voluntario)
        references voluntario (id_voluntario)
);

create table tarea (
    id_tarea     int  not null auto_increment,
    descripcion  text not null,
    fecha_inicio date not null,
    duracion     int  null,
    observacion  text null,
    constraint pk_tarea           primary key (id_tarea),
    constraint chk_tarea_duracion check (duracion > 0)
);

create table informe_actividad (
    id_asignacion int not null auto_increment,
    id_voluntario int not null,
    id_tarea      int not null,
    constraint pk_informe_actividad primary key (id_asignacion),
    constraint fk_ia_voluntario     foreign key (id_voluntario)
        references voluntario (id_voluntario),
    constraint fk_ia_tarea          foreign key (id_tarea)
        references tarea (id_tarea)
);

select * from usuario;