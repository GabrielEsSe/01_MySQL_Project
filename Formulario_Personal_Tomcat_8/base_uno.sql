create database base_uno;
use base_uno;

drop table registros;
create table registros(
	boleta 			varchar(20),
	nombre 			varchar(20), 
	especialidad 	varchar(30),
	turno 			varchar(20),
	beca 			varchar(20),
constraint pk_boleta primary key(boleta)
);

drop table T_R_I;
create table T_R_I(
	id_boleta		varchar(20),
    idioma			varchar(20),
    constraint fk_boleta foreign key(id_boleta) references registros(boleta));
insert into registros values ('109170', 'Gabriel', 'Programacion', 'Ingles', 'Matutino', '19000');
select * from registros;
select * from T_R_I;