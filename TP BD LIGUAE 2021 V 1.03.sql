drop table sedes cascade

drop table cursos cascade

drop table curso_alumnos cascade

drop table curso_docentes cascade

drop table eval_alumnos cascade

drop table evaluaciones cascade

drop table incidencias cascade

drop table informe_incidencias cascade

drop table pagos cascade

drop table personas cascade

drop table roles cascade

create table sedes(
	 cod_sede varchar(4) primary key not null,
	 provincia varchar(20) not null ,
	 cuidad varchar(20) not null ,
	 direccion varchar(50) not null unique,
	 telefono varchar(15) unique

)

--------------------------------------------------
drop table cursos

create table cursos(

	cod_idioma varchar(4) primary key not null,
	nombre varchar(10),
	nivel varchar(3) not null

	
)

---------------------------------------------------


create table personas(

	dni varchar(9) primary key not null,
	nombre varchar(50) not null,
	apellido varchar(50) not null,
	fecha_nac date not null,
	direccion varchar(50),
	telefono varchar(15)
)

-----------------------------------------------

--create domain dom_fechainicio date not null check(value >= current_date)
--Ejecutar despues de cargar las tablas para que el software haga lo suyo

create domain dom_puestos varchar(2) not null check(value in('DG','DI','SI','DO','EV','AL')) --crear ROLES de usuarios A,B,C  
create domain dom_fecha_cargos date not null check(value >= current_date )

drop table cargos


create table cargos(

	dni_persona varchar(9) references personas(dni),
	cod_sede  varchar(4) references sedes(cod_sede),
	nom_curso_idioma varchar(10),
	puesto dom_puestos,
	fecha_inicio dom_fecha_cargos,
	fecha_fin date	
)



------------------------------------------------------

create domain dom_fecha_eva date not null check(value >= current_date)
drop table evaluaciones
create table evaluaciones(

     nro_eval serial primary key,
	 dni_docente_evaluador varchar(9) references personas(dni),
	 cod_cursoidioma varchar(4) references cursos(cod_idioma),
	 fecha dom_fecha_eva
)


------------------------------------------------------------
create domain dom_nota int check(value >=1 and value <= 10)

create table eval_alumnos(

	dni_alumno varchar(9) references personas(dni),
	nro_eval int references evaluaciones(nro_eval),
	nota dom_nota,
	fecha date not null,
	ausente bool not null
	
)

----------------------------------------------------------

create domain dom_fechaini_curso_alumnos date not null check(value >= current_date)

DROP TABLE curso_alumnos
create table curso_alumnos(

	dni_alumno varchar(9) references personas(dni),
	cod_curso_idioma varchar(4) references cursos(cod_idioma),
	dia varchar(10) not null check( dia in('Lunes','Martes','Miercoles','Jueves', 'Viernes')),
	hora time not null,
	fecha_inicio dom_fechaini_curso_alumnos,
	fecha_fin date
)

------------------------------------------------------------
create domain dom_fechaini_curso_docentes date not null check(value >= current_date)
drop table curso_docentes

create table curso_docentes(

	dni_docente varchar(9)  references personas(dni),
	cod_curso_idioma varchar(4) references cursos(cod_idioma),
	dia varchar(10) not null check(dia in('Lunes','Martes','Miercoles','Jueves', 'Viernes')),
	hora time not null,
	fecha_inicio date,
	fecha_fin date
)

select * from curso_docentes

-------------------------------------------------------------
DROP TABLE PAGOS

DROP DOMAIN DOM_MONTO
create domain dom_monto decimal(10,2) not null check( value > 0 )

create table pagos(

	nro_comprobante serial primary key,
	cod_sede varchar(4) references sedes(cod_sede),
	cod_cursoidioma varchar(4) references cursos(cod_idioma),
	dni_alumno varchar(9) references personas(dni),
	fecha date default(current_date),
	monto dom_monto
)


------------------------------------------CARGA VALORES-------------------------------------------------------

insert into sedes values
('3100', 'Entre Rios', 'Paraná', 'Necochea 553', '+543434242791'),
('2000', 'Santa Fe', 'Rosario', 'Peron 123', '+543414657802'),
('5500', 'Mendoza', 'Mendoza', 'San Martin 456', '+542614316280')

--------------------------------------------------------------------------------------------------

insert into cursos values
('EA1P','Ingles', 'A1'),
('EA2P','Ingles', 'A2'),
('EB1P','Ingles', 'B1'),
('EB2P','Ingles', 'B2'),
('EC1P','Ingles', 'C1'),
('EC2P','Ingles', 'C2'),
('AA1P','Aleman', 'A1'),
('AA2P','Aleman', 'A2'),
('AB1P','Aleman', 'B1'),
('AB2P','Aleman', 'B2'),
('AC1P','Aleman', 'C1'),
('AC2P','Aleman', 'C2'),
('IA1P','Italiano', 'A1'),
('IA2P','Italiano', 'A2'),
('IB1P','Italiano', 'B1'),
('IB2P','Italiano', 'B2'),
('IC1P','Italiano', 'C1'),
('IC2P','Italiano', 'C2'),

('EA1V','Ingles', 'A1'),
('EA2V','Ingles', 'A2'),
('EB1V','Ingles', 'B1'),
('EB2V','Ingles', 'B2'),
('EC1V','Ingles', 'C1'),
('EC2V','Ingles', 'C2'),
('AA1V','Aleman', 'A1'),
('AA2V','Aleman', 'A2'),
('AB1V','Aleman', 'B1'),
('AB2V','Aleman', 'B2'),
('AC1V','Aleman', 'C1'),
('AC2V','Aleman', 'C2'),
('IA1V','Italiano', 'A1'),
('IA2V','Italiano', 'A2'),
('IB1V','Italiano', 'B1'),
('IB2V','Italiano', 'B2'),
('IC1V','Italiano', 'C1'),
('IC2V','Italiano', 'C2')

--------------------------------------------------------------------------------------------------------



insert into personas values
('32831554', 'Martin','Estrada','21-02-1987','Alsina 869', '3434636602'),
('37080129', 'Analia Belén','Cuenca','03-09-1992','Garrigó 1675 ', '3435029905'),
('35706276', 'Alejandro','Ghiringhelli','02-04-1991','Diamante 267', '3436230863'),
('31484774','Alfredo Francisco', 'Machado','01/06/1985', 'BoJ. Hernandez Manz. 4 C 2',  '4390678'),
('30563991','Ezequiel Eduardo','Mandel','18/08/1962', 'Gessino 216 Casa 14 Mzna. 4','4354128' ),
('30796852', 'Ana Estela','Ortiz','24/06/1985','Chacabuco 484','154502946' ),
('17022037', 'Omar Eliseo','Pitrovski','23/11/1980', 'Lomas del Mirador II Sec. A2','4246192' ),
('30560373','Xavier Emmanuel','Ramirez','18/08/1974', 'J. J. Hernandez Cuerpo 6 Mzna. 4','15537238'),
('32114702','Dario', 'Renna','13/08/1982','Barrio VICOER XII Mzna. A','0344287348' ),
('26152765','Emmanuel','Retamar','07/10/1982', 'BoHernandarias', '0315614420'  ),
('29269732', 'Gabriel Eugenio','Sosa','26/03/1986', 'Villaguay', '4341273' ),
('35441479','Guido Leonel','Suarez Rios','24/07/1981','Ayacucho 564',null ),
('29855862', 'Patricio Jose','Taurisano','25/10/1984', 'Santiago Derqui 749','4374410'),
('29957038','Pascual Timoteo A.','Uriona','11/03/1990', 'BoParana I Mzna 1','154553802' ),
('22850572','Leandro Raul','Vacaretti','25/06/1981', 'Nicanor Molina 511','4340448' ),
('22160011','Baltazar Carlos Eduardo','Wolff','04/07/1955', 'Jose M. Paz 1097','156238333' ),
('31277508','Leonardo Javier','Caceres','02/11/1982', 'Santiago Derqui 749','4840430' ),
('32188553', 'Javier','Filgueira','26/01/1984', 'Barrio Parana XIV Mzna. C','4390676' ),
('29157553','Angel Santiago','Flores','16/07/1978', 'BoJ.M. de Rosas Mzna. C2 Dpto 1','155042142' ),
('27337776','Juan Manuel','Iglesias','13/03/1984', 'La Rioja 331', '154684007' ),
('31579005','Luis Alejo','Romani','30/03/1988', 'Antonio Machado 703','156230784' ),
('33865514','Juan Pablo','Yacob','03/03/1977', 'Houssay 415', '154292170'),
('29447624','Luciano Miguel','Yugdar','24/07/1983', 'Barrio Parana XIV','154520300' ),
('28913190','Cynthia Noemi','Zacarias','06/07/1978', 'Berutti 640','154291709' ),
('29447678','Ivan Sergio Raul','Zanin','19/08/1982', 'Nicanor Molina 511','154786824' ),
('29945156','Maximiliano Juan Jose','Zapata','29/09/1982', 'Dr. Gessino 556','154297028' ),
('35441056','Cristhian Orlando','Diana','14/01/1988', 'Cordoba 162','0315590264'),
('36813450', 'Gaston Edurado', 'Perez', '23/10/1992', 'Laprida 751', '02915408269'),
('30578551', 'Jonathan Fabricio', 'Osorio', '03/11/1983', 'Los Paraisos 75', '4975377'),
('24752862', 'Federico Ivan', 'Pagura', '03/07/1975', 'Alsina 637', '03156234277'),
('25089771', 'Raul Virgilio', 'Rodriguez', '04/02/1976', 'Monte Caseros 323', '4227355'),
('36813449', 'Walter German Ramon', 'Wurstten', '13/02/1982', 'Laprida 760', '156117046'),
('21698023', 'Leonardo Juan Jose', 'Almada', '27/05/1970', 'Los Paraisos 75', '155032229'),
('32932173', 'Hernan Dario', 'Schmittlein', '23/10/1992', 'Alsina 654', '03156356487'),
('25089776', 'Gonzalo Exequiel', 'Saavedra', '25/02/1988', 'Rep. Dominicana 552', '155091007'),
('30408500', 'Gabriel Edurado', 'Martinez', '23/10/1992', 'Laprida 758', '02915408269'),
('29447005', 'Paola Soledad ', 'Roble' , '27/03/1982', 'Saravi 117', '4373580'),
('34586153', 'Yamila Haydee', 'Quintana', '16/07/1989', 'Los Jacarandaes 1173', '154732280'),
('26564401', 'Cynthia Carina', 'Popelka', '17/07/1978', 'Nogoya 49', '4231234')

 --Mas Campos------------------------------------------------------------------------------------
insert into personas values
('31313058', 'Juan Esteban','Piaggio','13/12/1984', 'Carrera y Vidal', NULL),
('25546396', 'Luis Maria', 'Piani', '26/11/1976', 'Moises Lebenshon 3426', '4351142'),
('34549524', 'Hugo Alejandro','Piantanida', '03/06/1989', 'Rio de los Pajaros 2716', '4331382'),
('37465542', 'Nicolas Daniel', 'Piccoli', '03/04/1993', 'Coronel Caminos 1329','4272812'),
('26519505', 'Soledad Lucrecia','Piccolo', '09/04/1978', 'Los Sauces 162', NULL),
('33838416', 'Alejandro Gabriel','Pico', '06/06/1988','Casiano Calderon 1888', '4272079'),
('27449041', 'Gabriel Jesus', 'Picotte', '10/10/1979', 'Virgen del Lujan 1951', '4271193'),
('29313095', 'Jorge Jesus','Picotte', '20/07/1982',  'Virgen del Lujan 1951', '4271193'),
('30196994', 'Maria De Los Angeles','Picotti', '25/02/1984', 'Pte. Peron 545', '4930302'),
('30322973', 'Matias Ismael','Picotti', '11/04/1984', '9 de julio 124',  '034156042'),
('28968427', 'Javier Luis','Pidone', '28/09/1981', 'Buenos Aires 441',  '4231109'),
--('29447103', 'Maximiliano Jose','Piedrabuena', '31/03/1982', 'Miller 1679', '4372486'),
('32509756', 'Ekaterina Micaela','Piergiovanni', '20/08/1986',  'Suipacha 1867', '4241228'),
('35706114', 'Miguel Martin','Piergiovanni', '13/03/1991',  'Gonzalez Pecotche 1896','4241228'),
('34586379', 'Mariano Hernan','Piffiguer', '04/09/1989', 'Dragones de Entre Rios 635', '154767142'),
('35448155', 'Juan Antonio','Pighin', '07/08/1990','A. Castellano 2097', '421779'),
('14330569', 'Walter Carlos', 'Pignatta', '05/09/1961', 'Ameghino 581','034432156'),
--('29447407', 'Federico', 'Pilnik', '20/06/1982', 'San Martin 118',  '4314439'),
--alumnos
('29447407', 'Federico','Pilnik', '20/06/1982', 'San Martin 118','4314439'),
('32327660', 'Bruno Andres','Pimentel', '02/04/1986',  'Los Ceibos 869', '4271012'),
('35706249', 'Maria Florencia','Pimentel', '27/03/1991', 'Los Ceibos 869', '03470805'),
('14604391', 'Raul Ceferino','Pin', '29/01/1961','Rep. Dominicana 640','4340487'),
('35708167', 'Micaela Anabel','Pineiro', '28/07/1991', 'Guemes 255', '03438421396'),
('37292002', 'Pedro Gustavo', 'Pineyro Santucci', '15/10/1992', 'Zona Rural 0', '037420511'),
('20096213', 'Raul Francisco', 'Pintos Sors', '15/03/1968','Rosario del Tala 512', '4221686'),
('23996958', 'Claudio Fabian','Pintos', '09/09/1974', 'Alvarado 2684',  '156217841'),
('31232287', 'Juan Emanuel','Pintos', '21/11/1984', 'Bvar. Sarmiento 579',  '4221239'),
('34972735', 'Carlos Eduardo de Jesus', 'Piris',  '26/12/1989', 'Gobernador Antelo 1683',  '154407421'),
('31760315', 'Vanina Maria Alejandra', 'Pirola', '06/08/1985',  'Los Sauces 243',  '4260625'),
('27466071', 'Pablo Martin','Pittavino', '14/07/1979', 'Las Lechiguanas 597', '4243187'),
('29447170', 'Nestor Ivan','Pizzichini', '08/04/1982',  'Regis Martinez 1735', '4246437'),
('26203750', 'Marianela','Pizzio', '16/11/1977',  'Gob. Parera 985', '4260093'),
('34678065', 'Diego Emanuel', 'Planes', '04/07/1989', 'La Delfina 1441', '4953903' ),
('32802059', 'Leandro Enrique', 'Planes', '19/05/1987', 'Turi 97','155035854'),
('30175494', 'Federico','Plaumer', '11/12/1984',  'Las Lechiguanas 571','4247784'),
('24592441', 'Claudia Rosana','Plez', '23/07/1975','Berio Acosta 1625', '155449461'),
('21411913', 'Cristian Raul','Pochon', '05/01/1970', 'Espana 267', '154476178'),
('36269182', 'Bruno Javier', 'Podversich', '20/01/1992', 'Zona Rural 0', '034154526051'),
('33349258', 'Eugenio Ezequiel','Podversich', '12/05/1988', 'Gervacio Mendez 519', '154388815'),
('25307515', 'Fernan Humberto','Poidomani', '01/08/1976', 'Cordoba 740','4317337'),
('34452406', 'Adrian Eduardo', 'Polarrolo', '15/09/1989', 'Ecuador 138', '4910435'),
('28676029', 'Graciela Valeria','Politi', '11/02/1981', 'Av. de las Americas', '4350114'),
('31017257', 'Exequiel Maximiliano','Polito Acosta', '28/07/1984',   'Gendarmeria Nacional 1637','4030909'),
('34821454', 'Franco Joel', 'Polo', '12/02/1990','Iriondo 1581','0348229033'),
('32058807', 'Laura', 'Ponce Bossio', '20/07/1986','San Martin 772',  '4973301'),
('23190739', 'Lucrecia Margarita Mercedes','Ponce', '09/08/1973', 'Independencia 958', '4880490'),
('34549589', 'Pablo Cesar','Ponce', '21/07/1989',  'Badano 0','154623501'),
('33271242', 'Francisco','Pons', '20/10/1987', '3 de Febrero', '4248909'),
('35441206', 'Juan Carlos','Poos', '15/11/1990', 'Coronel Uzin 555', '4349858'),
('32114383', 'Exequiel Dario', 'Popp', '26/03/1986','Misiones 1341', '49503502'),
('33927404', 'Gisela Mariel','Popp', '29/05/1988',  'Pasaje Moreno 74', '154388247'),
('34678024', 'Ivana Gisel','Popp', '05/06/1989', 'Misiones 1341', '4953502'),
('35442295', 'Jennifer Stefania', 'Popp', '29/09/1990', 'Rodriguez Pena 1034', '155048353'),
('31439635', 'Luciano','Porcaro', '25/02/1985',  'Av. Zanni 891', '4240872'),
('20096170', 'Orlando Javier','Porchnek', '24/02/1968', 'Av. Ramirez 3361', '4245155'),
('34059089', 'Mayka Antonella','Portal', '17/06/1990',  'Houssay 968',  '4910534'),
('37080626', 'Fabiola Maria del Mar','Portillo', '30/09/1992',  'Repetto 3804','0345422566'),
('32188504', 'Fabian Daniel', 'Portnoy', '18/02/1986', 'Almafuerte 225', '4245874'),
('35441760', 'Guillermo Luis','Portnoy', '22/01/1991', 'Almafuerte 225', '156111159'),
('33424056', 'Emanuel Maria','Porto Pereira', '15/12/1987', 'French 530','03156209229'),
('35164380', 'Marlene', 'Porto Pereira', '25/07/1990', 'French 530', '4994079'),
('35446262', 'Cristian Ezequiel','Portorreal', '07/08/1990',  'Pellegrini 1443','034754233'),
('30185183', 'Rodrigo Daniel','Postigo Werbrouck', '25/06/1983',  'Churruarin 525', '03156309443'),
('35289179', 'Milton', 'Pozzo', '14/09/1990','Belgrano 2548',  '03496-428955'),
('31384596', 'Nicolas Nazareno','Pozzo', '08/05/1985', 'Rio de Janeiro 76', '034430337'),
('32833780', 'Pablo Emanuel','Prada', '20/06/1987',   'Tomas Guido 2177', '4373172'),
('36910091', 'Geronimo Fabian','Pradella', '13/05/1992',  'Piran 5825', '4270220'),
('35295276', 'Daniel', 'Prado', '13/05/1990', 'Cuba 56', '4225161'),
('27139929', 'Danilo Martin','Pralong', '21/03/1979',   'Courrege 241', '4229766'),
('32745392', 'Sebastian Efrain', 'Pralong', '12/02/1987',  'H. Irigoyen 521', '4218164'),
('36452907', 'Agustin','Prediger', '13/03/1992',   'BoSan Salvador Casa 212',  '2901431913'),
('34669622', 'German', 'Prediger', '28/09/1989', 'Barrio San Salvador 212',  '029431913'),
('26713163', 'Andrea Marisel', 'Preisz', '29/01/1979', 'Diaz Colodrero 414',  '154285095'),
('35442432', 'Ariel Fernando', 'Preisz', '09/09/1990', 'Alejo Peyret 313',  '4235446')



select * from personas

--------------------------------------------------------------------------------------
truncate table roles

insert into cargos values
('17022037', null, null, 'DG', '20-03-2022' ),
('37080129', '3100', 'Ingles', 'DI', '10-03-2022' ),
('35706276', '3100', 'Aleman', 'DI' , '11-03-2022'),
('32831554', '3100', 'Italiano', 'DI' , '12-03-2022'),
('26564401', '2000', 'Ingles', 'DI', '13-03-2022' ),
('34586153', '2000', 'Aleman', 'DI' , '14-03-2022'),
('29447005', '2000', 'Italiano', 'DI' , '15-03-2022'),
('30408500', '5500', 'Ingles', 'DI' , '16-03-2022'),
('25089776', '5500', 'Aleman', 'DI' , '17-03-2022'),
('32932173', '5500', 'Italiano', 'DI' , '18-03-2022'),
('21698023', '3100', 'Ingles', 'SI' , '19-03-2022'),
('36813449', '3100', 'Aleman', 'SI' , '20-03-2022'),
('25089771', '3100', 'Italiano', 'SI' , '21-03-2022'),
('24752862', '2000', 'Ingles', 'SI', '22-03-2022' ),
('30578551', '2000', 'Aleman', 'SI', '23-03-2022' ),
('36813450', '2000', 'Italiano', 'SI' , '24-03-2022'),
('29447678', '5500', 'Ingles', 'SI', '25-03-2022' ),
('29945156', '5500', 'Aleman', 'SI', '26-03-2022' ),
('35441056', '5500', 'Italiano', 'SI', '27-03-2022' ),
--------------------------------------------------------------------------
('31484774','3100', 'Ingles', 'DO', '10-03-2022' ),
('30563991','3100', 'Ingles', 'DO', '10-03-2022' ),
('30796852', '3100', 'Ingles', 'EV', '10-03-2022' ),
('31313058', '3100', 'Ingles', 'EV', '10-03-2022' ),
('30560373', '3100', 'Aleman', 'DO' , '14-03-2022'),
('32114702', '3100', 'Aleman', 'DO' , '14-03-2022'),
('26152765', '3100', 'Aleman', 'EV' , '14-03-2022'),
('29269732',  '3100', 'Aleman', 'EV' , '14-03-2022'),
('35441479', '3100', 'Italiano', 'DO' , '14-03-2022'),
('29855862',  '3100', 'Italiano', 'DO' , '14-03-2022'),
('29957038', '3100', 'Italiano', 'EV' , '14-03-2022'),
('22850572', '3100', 'Italiano', 'EV' , '14-03-2022'),

('22160011', '2000', 'Ingles', 'DO' , '14-03-2022'),
('31277508', '2000', 'Ingles', 'DO' , '14-03-2022'),
('32188553', '2000', 'Ingles', 'EV', '10-03-2022' ),
('29157553', '2000', 'Ingles', 'EV', '10-03-2022' ),
('27337776', '2000', 'Aleman', 'DO' , '14-03-2022'),
('31579005', '2000', 'Aleman', 'DO' , '14-03-2022'),
('33865514','2000', 'Aleman', 'EV' , '14-03-2022'),
('29447624','2000', 'Aleman', 'EV' , '14-03-2022'),
('28913190','2000', 'Italiano', 'DO' , '14-03-2022'),
('31313058', '2000', 'Italiano', 'DO' , '14-03-2022'),
('25546396','2000', 'Italiano', 'EV' , '14-03-2022'),
('34549524','2000', 'Italiano', 'EV' , '14-03-2022'),

('37465542','5500', 'Ingles', 'DO', '10-03-2022' ),
('26519505','5500', 'Ingles', 'DO', '10-03-2022' ),
('33838416', '5500', 'Ingles', 'EV', '10-03-2022' ),
('27449041', '5500', 'Ingles', 'EV', '10-03-2022' ),
('29313095', '5500', 'Aleman', 'DO' , '14-03-2022'),
('30196994', '5500', 'Aleman', 'DO' , '14-03-2022'),
('30322973', '5500', 'Aleman', 'EV' , '14-03-2022'),
('32509756',  '5500', 'Aleman', 'EV' , '14-03-2022'),
('35706114', '5500', 'Italiano', 'DO' , '14-03-2022'),
('34586379',  '5500', 'Italiano', 'DO' , '14-03-2022'),
('35448155', '5500', 'Italiano', 'EV' , '14-03-2022'),
('14330569', '5500', 'Italiano', 'EV' , '14-03-2022')




select  count(*) from roles

select count(*) from personas
-----------------------------------------------------------------------------------------------


drop table evaluaciones

insert into evaluaciones (dni_docente_evaluador,cod_cursoidioma,fecha) values 
('31484774','EA1P', '10-12-2022' ),
('31484774','EA2P','11-12-2022'),
('31484774','EB1P','12-12-2022' ),
('31484774','EB2P', '13-12-2022' ),
('30563991','EC1P','14-12-2022' ),
('30563991','EC2P', '15-12-2022' ),
('30560373', 'AA1P', '18-12-2022'),
('30560373', 'AA2P', '19-12-2022'),
('30560373', 'AB1P', '20-12-2022'),
('30560373', 'AB2P', '21-12-2022'),
('32114702', 'AC1P', '22-12-2022'),
('32114702', 'AC2P', '10-12-2022'),
('35441479', 'IA1P', '11-12-2022'),
('35441479', 'IA2P', '12-12-2022'),
('35441479', 'IB1P',  '13-12-2022'),
('35441479', 'IB2P', '14-12-2022'),
('29855862',  'IC1P', '15-12-2022'),
('29855862',  'IC2P', '18-12-2022')




--------------------------------------------------------------------------------------------------
TRUNCATE TABLE CURSO_ALUMNOS

Insert into curso_alumnos values
('29447407', 'EA1P', 'Lunes','20:00', '04-03-2021', null),
('32327660', 'EA1P', 'Lunes','20:00', '04-03-2021', null),
('20096170', 'EA1P', 'Lunes','20:00', '04-03-2021', null),
('34059089', 'EA1P', 'Lunes','20:00', '04-03-2021', null),

('35706249', 'EA2P', 'Lunes','22:00', '04-03-2021', null),
('14604391', 'EA2P', 'Lunes','22:00', '04-03-2021', null),
('35164380', 'EA2P', 'Lunes','22:00', '04-03-2021', null),

('35708167', 'EB1V', 'Martes','20:00', '04-03-2021', null),
('37292002', 'EB1V', 'Martes','20:00', '04-03-2021', null),
('37080626', 'EB1V', 'Martes','20:00', '04-03-2021', null),
('32188504', 'EB1V', 'Martes','20:00', '04-03-2021', null),

('20096213', 'EB2V', 'Martes','22:00', '04-03-2021', null),
('23996958', 'EB2V', 'Martes','22:00', '04-03-2021', null),
('35446262', 'EB2V', 'Martes','22:00', '04-03-2021', null),

('31232287', 'EC1P', 'Miercoles','20:00', '04-03-2021', null),
('34972735', 'EC1P', 'Miercoles','20:00', '04-03-2021', null),
('35441760', 'EC1P', 'Miercoles','20:00', '04-03-2021', null),
('33424056', 'EC1P', 'Miercoles','20:00', '04-03-2021', null),

('31760315', 'EC2P', 'Miercoles','22:00', '04-03-2021', null),
('27466071', 'EC2P', 'Miercoles','22:00', '04-03-2021', null),

('29447170', 'AA1V', 'Jueves','20:00', '04-03-2021', null),
('26203750', 'AA1V', 'Jueves','20:00', '04-03-2021', null),
('36910091', 'AA1V', 'Jueves','20:00', '04-03-2021', null),
('35295276', 'AA1V', 'Jueves','20:00', '04-03-2021', null),

('34678065', 'AA2P', 'Jueves','22:00', '04-03-2021', null),
('32802059', 'AA2P', 'Jueves','22:00', '04-03-2021', null),


('30175494','AB1P', 'Viernes','20:00', '04-03-2021', null),
('24592441','AB1P', 'Viernes','20:00', '04-03-2021', null),
('36452907', 'AB1P', 'Viernes','20:00', '04-03-2021', null),
('34669622', 'AB1P', 'Viernes','20:00', '04-03-2021', null),

('26713163', 'AB2V', 'Viernes','22:00', '04-03-2021', null),
('35442432', 'AB2V', 'Viernes','22:00', '04-03-2021', null),
('21411913', 'AB2V', 'Viernes','22:00', '04-03-2021', null),
('36269182', 'AB2V', 'Viernes','22:00', '04-03-2021', null),

('33349258', 'AC1V', 'Lunes','17:00', '04-03-2021', null),
('25307515', 'AC1V', 'Lunes','17:00', '04-03-2021', null),
('30185183', 'AC1V', 'Lunes','17:00', '04-03-2021', null),
('35289179', 'AC1V', 'Lunes','17:00', '04-03-2021', null),

('34452406', 'AC2P', 'Lunes','19:00', '04-03-2021', null),
('28676029', 'AC2P', 'Lunes','19:00', '04-03-2021', null),

('31017257', 'IA1P', 'Martes','19:00', '04-03-2021', null),
('34821454', 'IA1P', 'Martes','19:00', '04-03-2021', null),
('31384596', 'IA1P', 'Martes','19:00', '04-03-2021', null),
('32833780', 'IA1P', 'Martes','19:00', '04-03-2021', null),

('32058807', 'IA2V', 'Martes','17:00', '04-03-2021', null),
('23190739', 'IA2V', 'Martes','17:00', '04-03-2021', null),

('34549589', 'IB1V', 'Miercoles','17:00', '04-03-2021', null),
('33271242', 'IB1V', 'Miercoles','17:00', '04-03-2021', null),

('35441206', 'IB2V', 'Miercoles','19:00', '04-03-2021', null),
('32114383', 'IB2V', 'Miercoles','19:00', '04-03-2021', null),

('33927404', 'IC1P', 'Jueves','17:00', '04-03-2021', null),
('34678024', 'IC1P', 'Jueves','17:00', '04-03-2021', null),
('27139929', 'IC1P', 'Jueves','17:00', '04-03-2021', null),
('32745392', 'IC1P', 'Jueves','17:00', '04-03-2021', null),

('35442295', 'IC2V', 'Jueves','19:00', '04-03-2021', null),
('31439635', 'IC2V', 'Jueves','19:00', '04-03-2021', null)

select * from curso_alumnos


-------------------------------------------------------------------------------------------------


insert into curso_docentes values
--parana
('31484774','EA1P','Lunes','20:00', '10-03-2021', null ),
('31484774','EA2P','Lunes','22:00', '10-03-2021', null ),
('31484774','EB1V','Martes','20:00', '10-03-2021', null ),
('31484774','EB2V','Martes','22:00', '10-03-2021', null ),
('30563991','EC1P','Miercoles','20:00' ,'10-03-2021' , null),
('30563991','EC2P','Miercoles','22:00', '10-03-2021', null ),
('30560373', 'AA1V' ,'Jueves','20:00', '14-03-2021', null),
('30560373', 'AA2P' ,'Jueves','22:00', '14-03-2021', null),
('30560373', 'AB1P' ,'Viernes','20:00', '14-03-2021', null),
('30560373', 'AB2V' ,'Viernes','22:00', '14-03-2021', null),
('32114702', 'AC1V' ,'Lunes','17:00', '14-03-2021', null),
('32114702', 'AC2P' ,'Lunes','19:00', '14-03-2021', null),
('35441479', 'IA1P', 'Martes','19:00', '14-03-2021', null),
('35441479', 'IA2V', 'Martes','17:00', '14-03-2021', null),
('35441479', 'IB1V','Miercoles','17:00',  '14-03-2021', null),
('35441479', 'IB2V', 'Miercoles','19:00', '14-03-2021', null),
('29855862',  'IC1V' ,'Jueves','17:00', '14-03-2021', null),
('29855862',  'IC2V' ,'Jueves','19:00', '14-03-2021', null),
--Rosario
('22160011','EA1P','Lunes','20:00', '10-03-2021', null ),
('22160011','EA2P', 'Lunes','22:00', '10-03-2021', null ),
('22160011','EB1P', 'Martes','20:00', '10-03-2021', null ),
('22160011','EB2P', 'Martes','22:00', '10-03-2021', null ),
('31277508','EC1P', 'Miercoles','20:00' ,'10-03-2021' , null),
('31277508','EC2P', 'Miercoles','22:00', '10-03-2021', null ),
('27337776', 'AA1V','Jueves','20:00', '14-03-2021', null),
('27337776', 'AA2V','Jueves','22:00', '14-03-2021', null),
('27337776', 'AB1V','Viernes','20:00', '14-03-2021', null),
('27337776', 'AB2V','Viernes','22:00', '14-03-2021', null),
('31579005', 'AC1V' ,'Lunes','17:00', '14-03-2021', null),
('31579005', 'AC2V' ,'Lunes','19:00', '14-03-2021', null),
('35441479', 'IA1P',  'Martes','19:00', '14-03-2021', null),
('35441479', 'IA2P',  'Martes','17:00', '14-03-2021', null),
('35441479', 'IB1P', 'Miercoles','17:00',  '14-03-2021', null),
('35441479', 'IB2P',  'Miercoles','19:00', '14-03-2021', null),
('29855862',  'IC1P', 'Jueves','17:00', '14-03-2021', null),
('29855862',  'IC2P', 'Jueves','19:00', '14-03-2021', null),
--mendoza
('37465542','EA1V','Lunes','20:00', '10-03-2021', null ),
('37465542','EA2V', 'Lunes','22:00', '10-03-2021', null ),
('37465542','EB1V', 'Martes','20:00', '10-03-2021', null ),
('37465542','EB2V', 'Martes','22:00', '10-03-2021', null ),
('26519505','EC1V', 'Miercoles','20:00' ,'10-03-2021' , null),
('26519505','EC2V', 'Miercoles','22:00', '10-03-2021', null ),
('29313095', 'AA1P','Jueves','20:00', '14-03-2021', null),
('29313095', 'AA2P','Jueves','22:00', '14-03-2021', null),
('29313095', 'AB1P','Viernes','20:00', '14-03-2021', null),
('29313095', 'AB2P','Viernes','22:00', '14-03-2021', null),
('30196994', 'AC1P' ,'Lunes','17:00', '14-03-2021', null),
('30196994', 'AC2P' ,'Lunes','19:00', '14-03-2021', null),
('35706114', 'IA1V',  'Martes','19:00', '14-03-2021', null),
('35706114', 'IA2V',  'Martes','17:00', '14-03-2021', null),
('35706114', 'IB1V', 'Miercoles','17:00',  '14-03-2021', null),
('35706114', 'IB2V',  'Miercoles','19:00', '14-03-2021', null),
('34586379',  'IC1V', 'Jueves','17:00', '14-03-2021', null),
('34586379',  'IC2V', 'Jueves','19:00', '14-03-2021', null)
 
----------------------------------------------------------------------------------------------------------------

insert into eval_alumnos values

('35706249', 1, 8, '10-12-2020', false),
('14604391', 1, 6, '10-12-2020', false),
('35164380', 1, 7, '10-12-2020', false),

('35708167',2, 9, '11-12-2020', false),
('37292002',2, 6, '11-12-2020', false),
('37080626', 2, 8, '11-12-2020', false),
('32188504', 2, 10, '11-12-2020', false),

('20096213', 3, 6, '12-12-2020', false),
('23996958', 3, 7, '12-12-2020', false),
('35446262', 3, 7, '12-12-2020', false),

('31232287', 4, 8, '13-12-2020', false),
('34972735', 4, 8, '13-12-2020', false),
('35441760', 4, 9, '13-12-2020', false),
('33424056', 4, 10, '13-12-2020', false),

('31760315', 5, 6, '14-12-2020', false),
('27466071', 5, 8, '14-12-2020', false),



('34678065', 7, 6, '18-12-2020', false),
('32802059', 7, 9, '18-12-2020', false),


('30175494',8, 7, '19-12-2020', false),
('24592441',8, 8, '19-12-2020', false),
('36452907', 8, 10, '19-12-2020', false),
('34669622', 8, 9, '19-12-2020', false),

('26713163', 9, 7, '20-12-2020', false),
('35442432', 9, 8, '20-12-2020', false),
('21411913', 9, 6, '20-12-2020', false),
('36269182', 9, 9, '20-12-2020', false),

('33349258', 10, 7, '21-12-2020', false),
('25307515', 10, 8, '21-12-2020', false),
('30185183', 10, 8, '21-12-2020', false),
('35289179', 10, 6, '21-12-2020', false),

('34452406', 11, 9, '22-12-2020', false),
('28676029', 11, 10, '22-12-2020', false),

('32058807', 13, 9, '11-12-2020', false),
('23190739', 13, 8, '11-12-2020', false),

('34549589', 14, 7, '12-12-2020', false),
('33271242', 14, 8, '12-12-2020', false),

('35441206', 15, 9, '13-12-2020', false),
('32114383', 15, 6, '13-12-2020', false),

('33927404', 16, 10, '14-12-2020', false),
('34678024', 16, 8, '14-12-2020', false),
('27139929', 16, 9, '14-12-2020', false),
('32745392', 16, 8, '14-12-2020', false),

('35442295', 17, 8, '15-12-2020', false),
('31439635', 17, 9, '15-12-2020', false)


------------------------------------------------------------------------------------------------------------------

insert into pagos (cod_sede, dni_alumno,  cod_cursoidioma,monto) values
('3100','29447407', 'EA1P', 2000),
('3100','32327660', 'EA1P', 2000),
('3100','20096170', 'EA1P', 2000),
('3100','34059089', 'EA1P', 2000),

('3100','35706249', 'EA2P', 2100),
('3100','14604391', 'EA2P', 2100),
('3100','35164380', 'EA2P', 2100),

('2000','35708167', 'EB1V', 2200),
('2000','37292002', 'EB1V', 2200),
('2000','37080626', 'EB1V', 2200),
('2000','32188504', 'EB1V', 2200),

('2000','20096213', 'EB2V', 2300),
('2000','23996958', 'EB2V', 2300),
('2000','35446262', 'EB2V', 2300),

('5500','31232287', 'EC1P', 2400),
('5500','34972735', 'EC1P', 2400),
('5500','35441760', 'EC1P', 2400),
('5500','33424056', 'EC1P', 2400),

('5500','31760315', 'EC2P', 2500),
('5500','27466071', 'EC2P', 2500),

('5500','29447170', 'AA1V', 2000),
('5500','26203750', 'AA1V', 2000),
('5500','36910091', 'AA1V', 2000),
('5500','35295276', 'AA1V', 2000),

('3100','34678065', 'AA2P', 2100),
('3100','32802059', 'AA2P', 2100),


('3100','30175494','AB1P', 2200),
('3100','24592441','AB1P', 2200),
('3100','36452907', 'AB1P', 2200),
('3100','34669622', 'AB1P', 2200),

('3100','26713163', 'AB2V', 2300),
('3100','35442432', 'AB2V', 2300),
('3100','21411913', 'AB2V', 2300),
('3100','36269182', 'AB2V', 2300),
('2000','33349258', 'AC1V', 2400),
('2000','25307515', 'AC1V', 2400),
('2000','30185183', 'AC1V', 2400),
('2000','35289179', 'AC1V', 2400),

('2000','34452406', 'AC2P', 2500),
('2000','28676029', 'AC2P', 2500),

('2000','31017257', 'IA1P', 2000),
('2000','34821454', 'IA1P', 2000),
('2000','31384596', 'IA1P', 2000),
('2000','32833780', 'IA1P', 2000),

('3100','32058807', 'IA2V', 2100),
('3100','23190739', 'IA2V', 2100),

('3100','34549589', 'IB1V', 2200),
('3100','33271242', 'IB1V', 2200),

('3100','35441206', 'IB2V', 2300),
('3100','32114383', 'IB2V', 2300),

('5500','33927404', 'IC1P', 2400),
('5500','34678024', 'IC1P', 2400),
('5500','27139929', 'IC1P', 2400),
('5500','32745392', 'IC1P', 2400),

('5500','35442295', 'IC2V', 2500),
('5500','31439635', 'IC2V', 2500)


select * from pagos


----------------------Salimo chaca-----------------------------------------------------------

select * from personas where apellido like '_% %'


select * from personas where nombre like '_% %'



--create view nombre_apellido as
select p.apellido||', '|| p.nombre  as nombres from personas p


drop index index_pago_alumno

create index index_pago_alumno on pagos(dni_alumno) 

SELECT * FROM  pagos where index_pago_alumno = '37080129'

--Generar los siguientes tipos de vistas:
-- Una vista que contemple la cantidad de cursos (asincrónicos/asincrónicos) y 
--sus docentes, así como también la cantidad de alumnos en cada uno de ellos.

select * from cursos
select * from curso_docentes
select * from curso_alumnos

create view datos_cursos as

select c.cod_idioma as Codigo, c.nombre as Idioma, count(ca.cod_curso_idioma) as Alumno, cd.dni_docente as dni , p.apellido||', '|| p.nombre as docente from cursos c
join curso_alumnos ca on( c.cod_idioma = ca.cod_curso_idioma )
join curso_docentes cd on( c.cod_idioma = cd.cod_curso_idioma) 
join personas p on( cd.dni_docente = p.dni)

group by  cd.dni_docente,c.cod_idioma, p.apellido, p.nombre



------------------------------------------------------
-- create view view_tablas2 as

-- SELECT relname,n_live_tup 
--   FROM pg_stat_user_tables 
--   ORDER BY n_live_tup DESC;



create view view_tablas as

select 'curso_alumnos', count(*) from curso_alumnos
union
select 'curso_docentes', count(*) from curso_docentes 
union
select 'cursos', count(*) from cursos
union
select 'eval_alumnos', count(*) from eval_alumnos
union
select 'evaluaciones', count(*) from evaluaciones
union
select 'pagos', count(*) from pagos
union
select 'personas', count(*) from personas
union
select 'roles', count(*) from roles
union
select 'sedes', count(*) from sedes


select * from view_tablas
--------------------------------------------------------------------------------

create domain dom_estado varchar(20) not null check(value in('Pendiente','Anulado','Finalizado'))

drop table incidencias

create table incidencias(

	cod serial primary key,
	tipo_incidente varchar(50) not null,
	cod_sede varchar(4) references sedes(cod_sede),
	fecha_incidente  date default(current_date) ,
	estado dom_estado
	
)

drop table informe_incidencia

create table informe_incidencia(

	cod_informe int references incidencias(cod),
	descripcion text not null,
	fecha_informe date default(current_date)
	
)

truncate table informe_incidencia


select * from incidencias

insert into incidencias (tipo_incidente, cod_usuario) values
('Error en el Menu','B')
insert into incidencias (tipo_incidente, cod_usuario) values
('Error en el Boton','B')



insert into informe_incidencia values
(1, 'C', 'El error del boton fue corregido')


select * from incidencias 

--create view gerente_informes as
select i.*, ii.* from informe_incidencia ii
right join incidencias i on(ii.cod_informe = i.cod )
where fecha_incidente between '2021-10-05' and '2021-11-06'


----------------------------------------------------------------------------------------------------------------------------
-- Función que reciba como parámetro de entrada un apellido y nombre y genere iniciales de 2 a 4 dígitos.

--sacar inicilaes de 2


create or replace function GenerarIniciales(nombre varchar(15), apellido varchar(15)) returns varchar(4) as 
$$
declare 
iniciales_nombre varchar(1);
iniciales_nombre2 varchar(1);
nombre_concat varchar(2);
inciales_apellido varchar(1);
inciales_apellido2 varchar(1);
apellido_concat varchar(2);
concat_iniciales varchar(4);
begin 
		
	iniciales_nombre = substring( (regexp_split_to_array(nombre, E'\\s+'))[1],1,1);	
	nombre_concat = iniciales_nombre;
	
	iniciales_nombre2 =substring( (regexp_split_to_array(nombre, E'\\s+'))[2],1,1);
	
 	if iniciales_nombre2 is not null then
 	nombre_concat = nombre_concat || iniciales_nombre2;
	end if;
	
	inciales_apellido =substring( (regexp_split_to_array(apellido, E'\\s+'))[1],1,1);
	apellido_concat = inciales_apellido;
 	
	inciales_apellido2 =substring( (regexp_split_to_array(apellido, E'\\s+'))[2],1,1);
	if inciales_apellido2 is not null then
 	apellido_concat = apellido_concat || inciales_apellido2;
 	end if;
	concat_iniciales = upper(nombre_concat) || upper(apellido_concat);
	
	return concat_iniciales ;
	
		
	
end;
$$
language 'plpgsql';

select GenerarIniciales(p.nombre, p.apellido ), p.nombre, p.apellido from personas p




---------------------------------------------------------------------------------------------------------------------

-- Función que permita determinar el precio de un curso (solo curso), el neto de 
--descuentos, recibiendo como parámetro, al menos el DNI del alumno.


---------------------ANDAAAAAA---------------------


create or replace function traer_pagos(dni varchar(9), descuento decimal(10,2)) returns decimal(10,2) as
$$
declare
	rec record;
	monto1 decimal(10,2);
begin
	for rec in select monto from pagos where dni_alumno = dni
	loop
		monto1 = rec.monto * (descuento/100);
	end loop;
	
	return monto1;
end;
$$
LANGUAGE plpgsql;

select traer_pagos('29447407', 50)




-- Llamado de la función

SELECT codigo, nombre, valor, descuentofijo(valor), vencimiento

FROM PRODUCTOS;

-------------------------------------------------------------------------------------------------


truncate table evaluaciones

create or replace function truncar_registros() returns void as
$$
begin
	begin
	
	truncate table informe_incidencia, incidencias, pagos, curso_docentes, curso_alumnos, eval_alumnos, evaluaciones, cargos, personas, cursos, sedes;
	end;
	
end;
$$
language 'plpgsql';

select truncar_registros()


create or replace function agregar_registros() returns void as
$$
begin
	begin
		insert into sedes values
		('3100', 'Entre Rios', 'Paraná', 'Necochea 553', '+543434242791'),
		('2000', 'Santa Fe', 'Rosario', 'Peron 123', '+543414657802'),
		('5500', 'Mendoza', 'Mendoza', 'San Martin 456', '+542614316280');
	end;
	
	begin
		insert into cursos values
		('EA1P','Ingles', 'A1'),
		('EA2P','Ingles', 'A2'),
		('EB1P','Ingles', 'B1'),
		('EB2P','Ingles', 'B2'),
		('EC1P','Ingles', 'C1'),
		('EC2P','Ingles', 'C2'),
		('AA1P','Aleman', 'A1'),
		('AA2P','Aleman', 'A2'),
		('AB1P','Aleman', 'B1'),
		('AB2P','Aleman', 'B2'),
		('AC1P','Aleman', 'C1'),
		('AC2P','Aleman', 'C2'),
		('IA1P','Italiano', 'A1'),
		('IA2P','Italiano', 'A2'),
		('IB1P','Italiano', 'B1'),
		('IB2P','Italiano', 'B2'),
		('IC1P','Italiano', 'C1'),
		('IC2P','Italiano', 'C2'),

		('EA1V','Ingles', 'A1'),
		('EA2V','Ingles', 'A2'),
		('EB1V','Ingles', 'B1'),
		('EB2V','Ingles', 'B2'),
		('EC1V','Ingles', 'C1'),
		('EC2V','Ingles', 'C2'),
		('AA1V','Aleman', 'A1'),
		('AA2V','Aleman', 'A2'),
		('AB1V','Aleman', 'B1'),
		('AB2V','Aleman', 'B2'),
		('AC1V','Aleman', 'C1'),
		('AC2V','Aleman', 'C2'),
		('IA1V','Italiano', 'A1'),
		('IA2V','Italiano', 'A2'),
		('IB1V','Italiano', 'B1'),
		('IB2V','Italiano', 'B2'),
		('IC1V','Italiano', 'C1'),
		('IC2V','Italiano', 'C2');
	end;
	
			begin
		insert into personas values
		('32831554', 'Martin','Estrada','21-02-1987','Alsina 869', '3434636602'),
		('37080129', 'Analia Belén','Cuenca','03-09-1992','Garrigó 1675 ', '3435029905'),
		('35706276', 'Alejandro','Ghiringhelli','02-04-1991','Diamante 267', '3436230863'),
		('31484774','Alfredo Francisco', 'Machado','01/06/1985', 'BoJ. Hernandez Manz. 4 C 2',  '4390678'),
		('30563991','Ezequiel Eduardo','Mandel','18/08/1962', 'Gessino 216 Casa 14 Mzna. 4','4354128' ),
		('30796852', 'Ana Estela','Ortiz','24/06/1985','Chacabuco 484','154502946' ),
		('17022037', 'Omar Eliseo','Pitrovski','23/11/1980', 'Lomas del Mirador II Sec. A2','4246192' ),
		('30560373','Xavier Emmanuel','Ramirez','18/08/1974', 'J. J. Hernandez Cuerpo 6 Mzna. 4','15537238'),
		('32114702','Dario', 'Renna','13/08/1982','Barrio VICOER XII Mzna. A','0344287348' ),
		('26152765','Emmanuel','Retamar','07/10/1982', 'BoHernandarias', '0315614420'  ),
		('29269732', 'Gabriel Eugenio','Sosa','26/03/1986', 'Villaguay', '4341273' ),
		('35441479','Guido Leonel','Suarez Rios','24/07/1981','Ayacucho 564',null ),
		('29855862', 'Patricio Jose','Taurisano','25/10/1984', 'Santiago Derqui 749','4374410'),
		('29957038','Pascual Timoteo A.','Uriona','11/03/1990', 'BoParana I Mzna 1','154553802' ),
		('22850572','Leandro Raul','Vacaretti','25/06/1981', 'Nicanor Molina 511','4340448' ),
		('22160011','Baltazar Carlos Eduardo','Wolff','04/07/1955', 'Jose M. Paz 1097','156238333' ),
		('31277508','Leonardo Javier','Caceres','02/11/1982', 'Santiago Derqui 749','4840430' ),
		('32188553', 'Javier','Filgueira','26/01/1984', 'Barrio Parana XIV Mzna. C','4390676' ),
		('29157553','Angel Santiago','Flores','16/07/1978', 'BoJ.M. de Rosas Mzna. C2 Dpto 1','155042142' ),
		('27337776','Juan Manuel','Iglesias','13/03/1984', 'La Rioja 331', '154684007' ),
		('31579005','Luis Alejo','Romani','30/03/1988', 'Antonio Machado 703','156230784' ),
		('33865514','Juan Pablo','Yacob','03/03/1977', 'Houssay 415', '154292170'),
		('29447624','Luciano Miguel','Yugdar','24/07/1983', 'Barrio Parana XIV','154520300' ),
		('28913190','Cynthia Noemi','Zacarias','06/07/1978', 'Berutti 640','154291709' ),
		('29447678','Ivan Sergio Raul','Zanin','19/08/1982', 'Nicanor Molina 511','154786824' ),
		('29945156','Maximiliano Juan Jose','Zapata','29/09/1982', 'Dr. Gessino 556','154297028' ),
		('35441056','Cristhian Orlando','Diana','14/01/1988', 'Cordoba 162','0315590264'),
		('36813450', 'Gaston Edurado', 'Perez', '23/10/1992', 'Laprida 751', '02915408269'),
		('30578551', 'Jonathan Fabricio', 'Osorio', '03/11/1983', 'Los Paraisos 75', '4975377'),
		('24752862', 'Federico Ivan', 'Pagura', '03/07/1975', 'Alsina 637', '03156234277'),
		('25089771', 'Raul Virgilio', 'Rodriguez', '04/02/1976', 'Monte Caseros 323', '4227355'),
		('36813449', 'Walter German Ramon', 'Wurstten', '13/02/1982', 'Laprida 760', '156117046'),
		('21698023', 'Leonardo Juan Jose', 'Almada', '27/05/1970', 'Los Paraisos 75', '155032229'),
		('32932173', 'Hernan Dario', 'Schmittlein', '23/10/1992', 'Alsina 654', '03156356487'),
		('25089776', 'Gonzalo Exequiel', 'Saavedra', '25/02/1988', 'Rep. Dominicana 552', '155091007'),
		('30408500', 'Gabriel Edurado', 'Martinez', '23/10/1992', 'Laprida 758', '02915408269'),
		('29447005', 'Paola Soledad ', 'Roble' , '27/03/1982', 'Saravi 117', '4373580'),
		('34586153', 'Yamila Haydee', 'Quintana', '16/07/1989', 'Los Jacarandaes 1173', '154732280'),
		('26564401', 'Cynthia Carina', 'Popelka', '17/07/1978', 'Nogoya 49', '4231234'),

		 --Mas Campos------------------------------------------------------------------------------------
		
		('31313058', 'Juan Esteban','Piaggio','13/12/1984', 'Carrera y Vidal', NULL),
		('25546396', 'Luis Maria', 'Piani', '26/11/1976', 'Moises Lebenshon 3426', '4351142'),
		('34549524', 'Hugo Alejandro','Piantanida', '03/06/1989', 'Rio de los Pajaros 2716', '4331382'),
		('37465542', 'Nicolas Daniel', 'Piccoli', '03/04/1993', 'Coronel Caminos 1329','4272812'),
		('26519505', 'Soledad Lucrecia','Piccolo', '09/04/1978', 'Los Sauces 162', NULL),
		('33838416', 'Alejandro Gabriel','Pico', '06/06/1988','Casiano Calderon 1888', '4272079'),
		('27449041', 'Gabriel Jesus', 'Picotte', '10/10/1979', 'Virgen del Lujan 1951', '4271193'),
		('29313095', 'Jorge Jesus','Picotte', '20/07/1982',  'Virgen del Lujan 1951', '4271193'),
		('30196994', 'Maria De Los Angeles','Picotti', '25/02/1984', 'Pte. Peron 545', '4930302'),
		('30322973', 'Matias Ismael','Picotti', '11/04/1984', '9 de julio 124',  '034156042'),
		('28968427', 'Javier Luis','Pidone', '28/09/1981', 'Buenos Aires 441',  '4231109'),
		--('29447103', 'Maximiliano Jose','Piedrabuena', '31/03/1982', 'Miller 1679', '4372486'),
		('32509756', 'Ekaterina Micaela','Piergiovanni', '20/08/1986',  'Suipacha 1867', '4241228'),
		('35706114', 'Miguel Martin','Piergiovanni', '13/03/1991',  'Gonzalez Pecotche 1896','4241228'),
		('34586379', 'Mariano Hernan','Piffiguer', '04/09/1989', 'Dragones de Entre Rios 635', '154767142'),
		('35448155', 'Juan Antonio','Pighin', '07/08/1990','A. Castellano 2097', '421779'),
		('14330569', 'Walter Carlos', 'Pignatta', '05/09/1961', 'Ameghino 581','034432156'),
		--('29447407', 'Federico', 'Pilnik', '20/06/1982', 'San Martin 118',  '4314439'),
		--alumnos
		('29447407', 'Federico','Pilnik', '20/06/1982', 'San Martin 118','4314439'),
		('32327660', 'Bruno Andres','Pimentel', '02/04/1986',  'Los Ceibos 869', '4271012'),
		('35706249', 'Maria Florencia','Pimentel', '27/03/1991', 'Los Ceibos 869', '03470805'),
		('14604391', 'Raul Ceferino','Pin', '29/01/1961','Rep. Dominicana 640','4340487'),
		('35708167', 'Micaela Anabel','Pineiro', '28/07/1991', 'Guemes 255', '03438421396'),
		('37292002', 'Pedro Gustavo', 'Pineyro Santucci', '15/10/1992', 'Zona Rural 0', '037420511'),
		('20096213', 'Raul Francisco', 'Pintos Sors', '15/03/1968','Rosario del Tala 512', '4221686'),
		('23996958', 'Claudio Fabian','Pintos', '09/09/1974', 'Alvarado 2684',  '156217841'),
		('31232287', 'Juan Emanuel','Pintos', '21/11/1984', 'Bvar. Sarmiento 579',  '4221239'),
		('34972735', 'Carlos Eduardo de Jesus', 'Piris',  '26/12/1989', 'Gobernador Antelo 1683',  '154407421'),
		('31760315', 'Vanina Maria Alejandra', 'Pirola', '06/08/1985',  'Los Sauces 243',  '4260625'),
		('27466071', 'Pablo Martin','Pittavino', '14/07/1979', 'Las Lechiguanas 597', '4243187'),
		('29447170', 'Nestor Ivan','Pizzichini', '08/04/1982',  'Regis Martinez 1735', '4246437'),
		('26203750', 'Marianela','Pizzio', '16/11/1977',  'Gob. Parera 985', '4260093'),
		('34678065', 'Diego Emanuel', 'Planes', '04/07/1989', 'La Delfina 1441', '4953903' ),
		('32802059', 'Leandro Enrique', 'Planes', '19/05/1987', 'Turi 97','155035854'),
		('30175494', 'Federico','Plaumer', '11/12/1984',  'Las Lechiguanas 571','4247784'),
		('24592441', 'Claudia Rosana','Plez', '23/07/1975','Berio Acosta 1625', '155449461'),
		('21411913', 'Cristian Raul','Pochon', '05/01/1970', 'Espana 267', '154476178'),
		('36269182', 'Bruno Javier', 'Podversich', '20/01/1992', 'Zona Rural 0', '034154526051'),
		('33349258', 'Eugenio Ezequiel','Podversich', '12/05/1988', 'Gervacio Mendez 519', '154388815'),
		('25307515', 'Fernan Humberto','Poidomani', '01/08/1976', 'Cordoba 740','4317337'),
		('34452406', 'Adrian Eduardo', 'Polarrolo', '15/09/1989', 'Ecuador 138', '4910435'),
		('28676029', 'Graciela Valeria','Politi', '11/02/1981', 'Av. de las Americas', '4350114'),
		('31017257', 'Exequiel Maximiliano','Polito Acosta', '28/07/1984',   'Gendarmeria Nacional 1637','4030909'),
		('34821454', 'Franco Joel', 'Polo', '12/02/1990','Iriondo 1581','0348229033'),
		('32058807', 'Laura', 'Ponce Bossio', '20/07/1986','San Martin 772',  '4973301'),
		('23190739', 'Lucrecia Margarita Mercedes','Ponce', '09/08/1973', 'Independencia 958', '4880490'),
		('34549589', 'Pablo Cesar','Ponce', '21/07/1989',  'Badano 0','154623501'),
		('33271242', 'Francisco','Pons', '20/10/1987', '3 de Febrero', '4248909'),
		('35441206', 'Juan Carlos','Poos', '15/11/1990', 'Coronel Uzin 555', '4349858'),
		('32114383', 'Exequiel Dario', 'Popp', '26/03/1986','Misiones 1341', '49503502'),
		('33927404', 'Gisela Mariel','Popp', '29/05/1988',  'Pasaje Moreno 74', '154388247'),
		('34678024', 'Ivana Gisel','Popp', '05/06/1989', 'Misiones 1341', '4953502'),
		('35442295', 'Jennifer Stefania', 'Popp', '29/09/1990', 'Rodriguez Pena 1034', '155048353'),
		('31439635', 'Luciano','Porcaro', '25/02/1985',  'Av. Zanni 891', '4240872'),
		('20096170', 'Orlando Javier','Porchnek', '24/02/1968', 'Av. Ramirez 3361', '4245155'),
		('34059089', 'Mayka Antonella','Portal', '17/06/1990',  'Houssay 968',  '4910534'),
		('37080626', 'Fabiola Maria del Mar','Portillo', '30/09/1992',  'Repetto 3804','0345422566'),
		('32188504', 'Fabian Daniel', 'Portnoy', '18/02/1986', 'Almafuerte 225', '4245874'),
		('35441760', 'Guillermo Luis','Portnoy', '22/01/1991', 'Almafuerte 225', '156111159'),
		('33424056', 'Emanuel Maria','Porto Pereira', '15/12/1987', 'French 530','03156209229'),
		('35164380', 'Marlene', 'Porto Pereira', '25/07/1990', 'French 530', '4994079'),
		('35446262', 'Cristian Ezequiel','Portorreal', '07/08/1990',  'Pellegrini 1443','034754233'),
		('30185183', 'Rodrigo Daniel','Postigo Werbrouck', '25/06/1983',  'Churruarin 525', '03156309443'),
		('35289179', 'Milton', 'Pozzo', '14/09/1990','Belgrano 2548',  '03496-428955'),
		('31384596', 'Nicolas Nazareno','Pozzo', '08/05/1985', 'Rio de Janeiro 76', '034430337'),
		('32833780', 'Pablo Emanuel','Prada', '20/06/1987',   'Tomas Guido 2177', '4373172'),
		('36910091', 'Geronimo Fabian','Pradella', '13/05/1992',  'Piran 5825', '4270220'),
		('35295276', 'Daniel', 'Prado', '13/05/1990', 'Cuba 56', '4225161'),
		('27139929', 'Danilo Martin','Pralong', '21/03/1979',   'Courrege 241', '4229766'),
		('32745392', 'Sebastian Efrain', 'Pralong', '12/02/1987',  'H. Irigoyen 521', '4218164'),
		('36452907', 'Agustin','Prediger', '13/03/1992',   'BoSan Salvador Casa 212',  '2901431913'),
		('34669622', 'German', 'Prediger', '28/09/1989', 'Barrio San Salvador 212',  '029431913'),
		('26713163', 'Andrea Marisel', 'Preisz', '29/01/1979', 'Diaz Colodrero 414',  '154285095'),
		('35442432', 'Ariel Fernando', 'Preisz', '09/09/1990', 'Alejo Peyret 313',  '4235446');
	end;
	
	begin

		insert into cargos values
		('17022037', null, null, 'DG', '20-03-2022' ),
		('37080129', '3100', 'Ingles', 'DI', '10-03-2022' ),
		('35706276', '3100', 'Aleman', 'DI' , '11-03-2022'),
		('32831554', '3100', 'Italiano', 'DI' , '12-03-2022'),
		('26564401', '2000', 'Ingles', 'DI', '13-03-2022' ),
		('34586153', '2000', 'Aleman', 'DI' , '14-03-2022'),
		('29447005', '2000', 'Italiano', 'DI' , '15-03-2022'),
		('30408500', '5500', 'Ingles', 'DI' , '16-03-2022'),
		('25089776', '5500', 'Aleman', 'DI' , '17-03-2022'),
		('32932173', '5500', 'Italiano', 'DI' , '18-03-2022'),
		('21698023', '3100', 'Ingles', 'SI' , '19-03-2022'),
		('36813449', '3100', 'Aleman', 'SI' , '20-03-2022'),
		('25089771', '3100', 'Italiano', 'SI' , '21-03-2022'),
		('24752862', '2000', 'Ingles', 'SI', '22-03-2022' ),
		('30578551', '2000', 'Aleman', 'SI', '23-03-2022' ),
		('36813450', '2000', 'Italiano', 'SI' , '24-03-2022'),
		('29447678', '5500', 'Ingles', 'SI', '25-03-2022' ),
		('29945156', '5500', 'Aleman', 'SI', '26-03-2022' ),
		('35441056', '5500', 'Italiano', 'SI', '27-03-2022' ),
		--------------------------------------------------------------------------
		('31484774','3100', 'Ingles', 'DO', '10-03-2022' ),
		('30563991','3100', 'Ingles', 'DO', '10-03-2022' ),
		('30796852', '3100', 'Ingles', 'EV', '10-03-2022' ),
		('31313058', '3100', 'Ingles', 'EV', '10-03-2022' ),
		('30560373', '3100', 'Aleman', 'DO' , '14-03-2022'),
		('32114702', '3100', 'Aleman', 'DO' , '14-03-2022'),
		('26152765', '3100', 'Aleman', 'EV' , '14-03-2022'),
		('29269732',  '3100', 'Aleman', 'EV' , '14-03-2022'),
		('35441479', '3100', 'Italiano', 'DO' , '14-03-2022'),
		('29855862',  '3100', 'Italiano', 'DO' , '14-03-2022'),
		('29957038', '3100', 'Italiano', 'EV' , '14-03-2022'),
		('22850572', '3100', 'Italiano', 'EV' , '14-03-2022'),

		('22160011', '2000', 'Ingles', 'DO' , '14-03-2022'),
		('31277508', '2000', 'Ingles', 'DO' , '14-03-2022'),
		('32188553', '2000', 'Ingles', 'EV', '10-03-2022' ),
		('29157553', '2000', 'Ingles', 'EV', '10-03-2022' ),
		('27337776', '2000', 'Aleman', 'DO' , '14-03-2022'),
		('31579005', '2000', 'Aleman', 'DO' , '14-03-2022'),
		('33865514','2000', 'Aleman', 'EV' , '14-03-2022'),
		('29447624','2000', 'Aleman', 'EV' , '14-03-2022'),
		('28913190','2000', 'Italiano', 'DO' , '14-03-2022'),
		('31313058', '2000', 'Italiano', 'DO' , '14-03-2022'),
		('25546396','2000', 'Italiano', 'EV' , '14-03-2022'),
		('34549524','2000', 'Italiano', 'EV' , '14-03-2022'),

		('37465542','5500', 'Ingles', 'DO', '10-03-2022' ),
		('26519505','5500', 'Ingles', 'DO', '10-03-2022' ),
		('33838416', '5500', 'Ingles', 'EV', '10-03-2022' ),
		('27449041', '5500', 'Ingles', 'EV', '10-03-2022' ),
		('29313095', '5500', 'Aleman', 'DO' , '14-03-2022'),
		('30196994', '5500', 'Aleman', 'DO' , '14-03-2022'),
		('30322973', '5500', 'Aleman', 'EV' , '14-03-2022'),
		('32509756',  '5500', 'Aleman', 'EV' , '14-03-2022'),
		('35706114', '5500', 'Italiano', 'DO' , '14-03-2022'),
		('34586379',  '5500', 'Italiano', 'DO' , '14-03-2022'),
		('35448155', '5500', 'Italiano', 'EV' , '14-03-2022'),
		('14330569', '5500', 'Italiano', 'EV' , '14-03-2022');
	end;
	
	begin		
		insert into evaluaciones (dni_docente_evaluador,cod_cursoidioma,fecha) values 
		('31484774','EA1P', '10-12-2022' ),
		('31484774','EA2P','11-12-2022'),
		('31484774','EB1P','12-12-2022' ),
		('31484774','EB2P', '13-12-2022' ),
		('30563991','EC1P','14-12-2022' ),
		('30563991','EC2P', '15-12-2022' ),
		('30560373', 'AA1P', '18-12-2022'),
		('30560373', 'AA2P', '19-12-2022'),
		('30560373', 'AB1P', '20-12-2022'),
		('30560373', 'AB2P', '21-12-2022'),
		('32114702', 'AC1P', '22-12-2022'),
		('32114702', 'AC2P', '10-12-2022'),
		('35441479', 'IA1P', '11-12-2022'),
		('35441479', 'IA2P', '12-12-2022'),
		('35441479', 'IB1P',  '13-12-2022'),
		('35441479', 'IB2P', '14-12-2022'),
		('29855862',  'IC1P', '15-12-2022'),
		('29855862',  'IC2P', '18-12-2022');
	
	end;
	
	begin

		Insert into curso_alumnos values
		('29447407', 'EA1P', 'Lunes','20:00', '04-03-2021', null),
		('32327660', 'EA1P', 'Lunes','20:00', '04-03-2021', null),
		('20096170', 'EA1P', 'Lunes','20:00', '04-03-2021', null),
		('34059089', 'EA1P', 'Lunes','20:00', '04-03-2021', null),

		('35706249', 'EA2P', 'Lunes','22:00', '04-03-2021', null),
		('14604391', 'EA2P', 'Lunes','22:00', '04-03-2021', null),
		('35164380', 'EA2P', 'Lunes','22:00', '04-03-2021', null),

		('35708167', 'EB1V', 'Martes','20:00', '04-03-2021', null),
		('37292002', 'EB1V', 'Martes','20:00', '04-03-2021', null),
		('37080626', 'EB1V', 'Martes','20:00', '04-03-2021', null),
		('32188504', 'EB1V', 'Martes','20:00', '04-03-2021', null),

		('20096213', 'EB2V', 'Martes','22:00', '04-03-2021', null),
		('23996958', 'EB2V', 'Martes','22:00', '04-03-2021', null),
		('35446262', 'EB2V', 'Martes','22:00', '04-03-2021', null),

		('31232287', 'EC1P', 'Miercoles','20:00', '04-03-2021', null),
		('34972735', 'EC1P', 'Miercoles','20:00', '04-03-2021', null),
		('35441760', 'EC1P', 'Miercoles','20:00', '04-03-2021', null),
		('33424056', 'EC1P', 'Miercoles','20:00', '04-03-2021', null),

		('31760315', 'EC2P', 'Miercoles','22:00', '04-03-2021', null),
		('27466071', 'EC2P', 'Miercoles','22:00', '04-03-2021', null),

		('29447170', 'AA1V', 'Jueves','20:00', '04-03-2021', null),
		('26203750', 'AA1V', 'Jueves','20:00', '04-03-2021', null),
		('36910091', 'AA1V', 'Jueves','20:00', '04-03-2021', null),
		('35295276', 'AA1V', 'Jueves','20:00', '04-03-2021', null),

		('34678065', 'AA2P', 'Jueves','22:00', '04-03-2021', null),
		('32802059', 'AA2P', 'Jueves','22:00', '04-03-2021', null),


		('30175494','AB1P', 'Viernes','20:00', '04-03-2021', null),
		('24592441','AB1P', 'Viernes','20:00', '04-03-2021', null),
		('36452907', 'AB1P', 'Viernes','20:00', '04-03-2021', null),
		('34669622', 'AB1P', 'Viernes','20:00', '04-03-2021', null),

		('26713163', 'AB2V', 'Viernes','22:00', '04-03-2021', null),
		('35442432', 'AB2V', 'Viernes','22:00', '04-03-2021', null),
		('21411913', 'AB2V', 'Viernes','22:00', '04-03-2021', null),
		('36269182', 'AB2V', 'Viernes','22:00', '04-03-2021', null),

		('33349258', 'AC1V', 'Lunes','17:00', '04-03-2021', null),
		('25307515', 'AC1V', 'Lunes','17:00', '04-03-2021', null),
		('30185183', 'AC1V', 'Lunes','17:00', '04-03-2021', null),
		('35289179', 'AC1V', 'Lunes','17:00', '04-03-2021', null),

		('34452406', 'AC2P', 'Lunes','19:00', '04-03-2021', null),
		('28676029', 'AC2P', 'Lunes','19:00', '04-03-2021', null),

		('31017257', 'IA1P', 'Martes','19:00', '04-03-2021', null),
		('34821454', 'IA1P', 'Martes','19:00', '04-03-2021', null),
		('31384596', 'IA1P', 'Martes','19:00', '04-03-2021', null),
		('32833780', 'IA1P', 'Martes','19:00', '04-03-2021', null),

		('32058807', 'IA2V', 'Martes','17:00', '04-03-2021', null),
		('23190739', 'IA2V', 'Martes','17:00', '04-03-2021', null),

		('34549589', 'IB1V', 'Miercoles','17:00', '04-03-2021', null),
		('33271242', 'IB1V', 'Miercoles','17:00', '04-03-2021', null),

		('35441206', 'IB2V', 'Miercoles','19:00', '04-03-2021', null),
		('32114383', 'IB2V', 'Miercoles','19:00', '04-03-2021', null),

		('33927404', 'IC1P', 'Jueves','17:00', '04-03-2021', null),
		('34678024', 'IC1P', 'Jueves','17:00', '04-03-2021', null),
		('27139929', 'IC1P', 'Jueves','17:00', '04-03-2021', null),
		('32745392', 'IC1P', 'Jueves','17:00', '04-03-2021', null),

		('35442295', 'IC2V', 'Jueves','19:00', '04-03-2021', null),
		('31439635', 'IC2V', 'Jueves','19:00', '04-03-2021', null);
	
	end;
	
	begin
		insert into curso_docentes values
		--parana
		('31484774','EA1P','Lunes','20:00', '10-03-2021', null ),
		('31484774','EA2P','Lunes','22:00', '10-03-2021', null ),
		('31484774','EB1V','Martes','20:00', '10-03-2021', null ),
		('31484774','EB2V','Martes','22:00', '10-03-2021', null ),
		('30563991','EC1P','Miercoles','20:00' ,'10-03-2021' , null),
		('30563991','EC2P','Miercoles','22:00', '10-03-2021', null ),
		('30560373', 'AA1V' ,'Jueves','20:00', '14-03-2021', null),
		('30560373', 'AA2P' ,'Jueves','22:00', '14-03-2021', null),
		('30560373', 'AB1P' ,'Viernes','20:00', '14-03-2021', null),
		('30560373', 'AB2V' ,'Viernes','22:00', '14-03-2021', null),
		('32114702', 'AC1V' ,'Lunes','17:00', '14-03-2021', null),
		('32114702', 'AC2P' ,'Lunes','19:00', '14-03-2021', null),
		('35441479', 'IA1P', 'Martes','19:00', '14-03-2021', null),
		('35441479', 'IA2V', 'Martes','17:00', '14-03-2021', null),
		('35441479', 'IB1V','Miercoles','17:00',  '14-03-2021', null),
		('35441479', 'IB2V', 'Miercoles','19:00', '14-03-2021', null),
		('29855862',  'IC1V' ,'Jueves','17:00', '14-03-2021', null),
		('29855862',  'IC2V' ,'Jueves','19:00', '14-03-2021', null),
		--Rosario
		('22160011','EA1P','Lunes','20:00', '10-03-2021', null ),
		('22160011','EA2P', 'Lunes','22:00', '10-03-2021', null ),
		('22160011','EB1P', 'Martes','20:00', '10-03-2021', null ),
		('22160011','EB2P', 'Martes','22:00', '10-03-2021', null ),
		('31277508','EC1P', 'Miercoles','20:00' ,'10-03-2021' , null),
		('31277508','EC2P', 'Miercoles','22:00', '10-03-2021', null ),
		('27337776', 'AA1V','Jueves','20:00', '14-03-2021', null),
		('27337776', 'AA2V','Jueves','22:00', '14-03-2021', null),
		('27337776', 'AB1V','Viernes','20:00', '14-03-2021', null),
		('27337776', 'AB2V','Viernes','22:00', '14-03-2021', null),
		('31579005', 'AC1V' ,'Lunes','17:00', '14-03-2021', null),
		('31579005', 'AC2V' ,'Lunes','19:00', '14-03-2021', null),
		('35441479', 'IA1P',  'Martes','19:00', '14-03-2021', null),
		('35441479', 'IA2P',  'Martes','17:00', '14-03-2021', null),
		('35441479', 'IB1P', 'Miercoles','17:00',  '14-03-2021', null),
		('35441479', 'IB2P',  'Miercoles','19:00', '14-03-2021', null),
		('29855862',  'IC1P', 'Jueves','17:00', '14-03-2021', null),
		('29855862',  'IC2P', 'Jueves','19:00', '14-03-2021', null),
		--mendoza
		('37465542','EA1V','Lunes','20:00', '10-03-2021', null ),
		('37465542','EA2V', 'Lunes','22:00', '10-03-2021', null ),
		('37465542','EB1V', 'Martes','20:00', '10-03-2021', null ),
		('37465542','EB2V', 'Martes','22:00', '10-03-2021', null ),
		('26519505','EC1V', 'Miercoles','20:00' ,'10-03-2021' , null),
		('26519505','EC2V', 'Miercoles','22:00', '10-03-2021', null ),
		('29313095', 'AA1P','Jueves','20:00', '14-03-2021', null),
		('29313095', 'AA2P','Jueves','22:00', '14-03-2021', null),
		('29313095', 'AB1P','Viernes','20:00', '14-03-2021', null),
		('29313095', 'AB2P','Viernes','22:00', '14-03-2021', null),
		('30196994', 'AC1P' ,'Lunes','17:00', '14-03-2021', null),
		('30196994', 'AC2P' ,'Lunes','19:00', '14-03-2021', null),
		('35706114', 'IA1V',  'Martes','19:00', '14-03-2021', null),
		('35706114', 'IA2V',  'Martes','17:00', '14-03-2021', null),
		('35706114', 'IB1V', 'Miercoles','17:00',  '14-03-2021', null),
		('35706114', 'IB2V',  'Miercoles','19:00', '14-03-2021', null),
		('34586379',  'IC1V', 'Jueves','17:00', '14-03-2021', null),
		('34586379',  'IC2V', 'Jueves','19:00', '14-03-2021', null);	
	end;
	
	begin

		insert into eval_alumnos values

		('35706249', 1, 8, '10-12-2020', false),
		('14604391', 1, 6, '10-12-2020', false),
		('35164380', 1, 7, '10-12-2020', false),

		('35708167',2, 9, '11-12-2020', false),
		('37292002',2, 6, '11-12-2020', false),
		('37080626', 2, 8, '11-12-2020', false),
		('32188504', 2, 10, '11-12-2020', false),

		('20096213', 3, 6, '12-12-2020', false),
		('23996958', 3, 7, '12-12-2020', false),
		('35446262', 3, 7, '12-12-2020', false),

		('31232287', 4, 8, '13-12-2020', false),
		('34972735', 4, 8, '13-12-2020', false),
		('35441760', 4, 9, '13-12-2020', false),
		('33424056', 4, 10, '13-12-2020', false),

		('31760315', 5, 6, '14-12-2020', false),
		('27466071', 5, 8, '14-12-2020', false),



		('34678065', 7, 6, '18-12-2020', false),
		('32802059', 7, 9, '18-12-2020', false),


		('30175494',8, 7, '19-12-2020', false),
		('24592441',8, 8, '19-12-2020', false),
		('36452907', 8, 10, '19-12-2020', false),
		('34669622', 8, 9, '19-12-2020', false),

		('26713163', 9, 7, '20-12-2020', false),
		('35442432', 9, 8, '20-12-2020', false),
		('21411913', 9, 6, '20-12-2020', false),
		('36269182', 9, 9, '20-12-2020', false),

		('33349258', 10, 7, '21-12-2020', false),
		('25307515', 10, 8, '21-12-2020', false),
		('30185183', 10, 8, '21-12-2020', false),
		('35289179', 10, 6, '21-12-2020', false),

		('34452406', 11, 9, '22-12-2020', false),
		('28676029', 11, 10, '22-12-2020', false),

		('32058807', 13, 9, '11-12-2020', false),
		('23190739', 13, 8, '11-12-2020', false),

		('34549589', 14, 7, '12-12-2020', false),
		('33271242', 14, 8, '12-12-2020', false),

		('35441206', 15, 9, '13-12-2020', false),
		('32114383', 15, 6, '13-12-2020', false),

		('33927404', 16, 10, '14-12-2020', false),
		('34678024', 16, 8, '14-12-2020', false),
		('27139929', 16, 9, '14-12-2020', false),
		('32745392', 16, 8, '14-12-2020', false),

		('35442295', 17, 8, '15-12-2020', false),
		('31439635', 17, 9, '15-12-2020', false);
	
	end;
	
	begin
		insert into pagos (cod_sede, dni_alumno,  cod_cursoidioma,monto) values
		('3100','29447407', 'EA1P', 2000),
		('3100','32327660', 'EA1P', 2000),
		('3100','20096170', 'EA1P', 2000),
		('3100','34059089', 'EA1P', 2000),

		('3100','35706249', 'EA2P', 2100),
		('3100','14604391', 'EA2P', 2100),
		('3100','35164380', 'EA2P', 2100),

		('2000','35708167', 'EB1V', 2200),
		('2000','37292002', 'EB1V', 2200),
		('2000','37080626', 'EB1V', 2200),
		('2000','32188504', 'EB1V', 2200),

		('2000','20096213', 'EB2V', 2300),
		('2000','23996958', 'EB2V', 2300),
		('2000','35446262', 'EB2V', 2300),

		('5500','31232287', 'EC1P', 2400),
		('5500','34972735', 'EC1P', 2400),
		('5500','35441760', 'EC1P', 2400),
		('5500','33424056', 'EC1P', 2400),

		('5500','31760315', 'EC2P', 2500),
		('5500','27466071', 'EC2P', 2500),

		('5500','29447170', 'AA1V', 2000),
		('5500','26203750', 'AA1V', 2000),
		('5500','36910091', 'AA1V', 2000),
		('5500','35295276', 'AA1V', 2000),

		('3100','34678065', 'AA2P', 2100),
		('3100','32802059', 'AA2P', 2100),


		('3100','30175494','AB1P', 2200),
		('3100','24592441','AB1P', 2200),
		('3100','36452907', 'AB1P', 2200),
		('3100','34669622', 'AB1P', 2200),

		('3100','26713163', 'AB2V', 2300),
		('3100','35442432', 'AB2V', 2300),
		('3100','21411913', 'AB2V', 2300),
		('3100','36269182', 'AB2V', 2300),
		('2000','33349258', 'AC1V', 2400),
		('2000','25307515', 'AC1V', 2400),
		('2000','30185183', 'AC1V', 2400),
		('2000','35289179', 'AC1V', 2400),

		('2000','34452406', 'AC2P', 2500),
		('2000','28676029', 'AC2P', 2500),

		('2000','31017257', 'IA1P', 2000),
		('2000','34821454', 'IA1P', 2000),
		('2000','31384596', 'IA1P', 2000),
		('2000','32833780', 'IA1P', 2000),

		('3100','32058807', 'IA2V', 2100),
		('3100','23190739', 'IA2V', 2100),

		('3100','34549589', 'IB1V', 2200),
		('3100','33271242', 'IB1V', 2200),

		('3100','35441206', 'IB2V', 2300),
		('3100','32114383', 'IB2V', 2300),

		('5500','33927404', 'IC1P', 2400),
		('5500','34678024', 'IC1P', 2400),
		('5500','27139929', 'IC1P', 2400),
		('5500','32745392', 'IC1P', 2400),

		('5500','35442295', 'IC2V', 2500),
		('5500','31439635', 'IC2V', 2500);
	end;
	begin
		
		insert into incidencias (tipo_incidente, cod_sede, estado) values
		('Error en el sistema', '3100','Pendiente'),
		('Error en el Boton','2000', 'Finalizado');		
	end;
	
	begin 
		insert into informe_incidencia values
		(1, 'se esta trabajando en el problema'),
		(2, 'El error del boton fue corregido');
	end;
end;
$$
language 'plpgsql';


select * from agregar_registros()


select * from informe_incidencia;
select * from incidencias;
select * from pagos;
select * from curso_alumnos;
select * from curso_docentes;
select * from eval_alumnos;
select * from evaluaciones;
select * from cursos;
select * from cargos;
select * from personas;
select * from sedes;



