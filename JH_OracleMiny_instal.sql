--obtiznost
  CREATE TABLE "JH"."OBTIZNOST" 
   (	"ID_OBTIZNOST" NUMBER NOT NULL ENABLE, 
	"NAZEV" VARCHAR2(20 CHAR), 
	"RADKY" NUMBER, 
	"SLOUPCE" NUMBER, 
	"POCET_MIN" NUMBER, 
	 CONSTRAINT "OBTIZNOST_PK" PRIMARY KEY ("ID_OBTIZNOST")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "JH_TBS_PERM"  ENABLE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "JH_TBS_PERM" ;

--oblast
  CREATE TABLE "JH"."OBLAST" 
   (	"ID_OBLAST" NUMBER NOT NULL ENABLE, 
	"RADKY" NUMBER NOT NULL ENABLE, 
	"SLOUPCE" NUMBER NOT NULL ENABLE, 
	"POCET_MIN" NUMBER NOT NULL ENABLE, 
	"OBTIZNOST_ID_OBTIZNOST" NUMBER, 
	 CONSTRAINT "OBLAST_PK" PRIMARY KEY ("ID_OBLAST")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "JH_TBS_PERM"  ENABLE, 
	 CONSTRAINT "OBLAST_OBTIZNOST_FK" FOREIGN KEY ("OBTIZNOST_ID_OBTIZNOST")
	  REFERENCES "JH"."OBTIZNOST" ("ID_OBTIZNOST") ENABLE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "JH_TBS_PERM" ;

  CREATE OR REPLACE TRIGGER "JH"."TRAI_OBLAST" 
AFTER INSERT ON OBLAST 
FOR EACH ROW
BEGIN
  --vytvoreni zaznamù v tabulce pole
  FOR x IN 1..:NEW.SLOUPCE LOOP  
    FOR y IN 1..:NEW.RADKY LOOP
        Insert into Pole values (seq_pole.nextval,y,x,0,0,:NEW.ID_OBLAST,0);
    END LOOP;
  END LOOP;
  ZAMINUJ_OBLAST(:NEW.ID_OBLAST,:NEW.RADKY,:NEW.SLOUPCE,:NEW.POCET_MIN);
  SPOCITEJ_OBLAST (:NEW.ID_OBLAST,:NEW.RADKY,:NEW.SLOUPCE);
  --vytvoreni zaznamu v tabulce hra
  insert into hra values(seq_hra.nextval,null,null,0,1,:NEW.ID_OBLAST);
  --zaminování oblasti
 
END;
/
ALTER TRIGGER "JH"."TRAI_OBLAST" ENABLE;

--stav
  CREATE TABLE "JH"."STAV" 
   (	"ID_STAV" NUMBER NOT NULL ENABLE, 
	"NAZEV" VARCHAR2(20 CHAR), 
	 CONSTRAINT "STAV_PK" PRIMARY KEY ("ID_STAV")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "JH_TBS_PERM"  ENABLE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "JH_TBS_PERM" ;
--hra
  CREATE TABLE "JH"."HRA" 
   (	"ID_HRA" NUMBER NOT NULL ENABLE, 
	"PRVNI_TAH" DATE, 
	"POSLEDNI_TAH" DATE, 
	"POCET_OZNACENYCH_MIN" NUMBER, 
	"STAV_ID_STAV" NUMBER NOT NULL ENABLE, 
	"OBLAST_ID_OBLAST" NUMBER NOT NULL ENABLE, 
	 CONSTRAINT "HRA_PK" PRIMARY KEY ("ID_HRA")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "JH_TBS_PERM"  ENABLE, 
	 CONSTRAINT "HRA_OBLAST_FK" FOREIGN KEY ("OBLAST_ID_OBLAST")
	  REFERENCES "JH"."OBLAST" ("ID_OBLAST") ENABLE, 
	 CONSTRAINT "HRA_STAV_FK" FOREIGN KEY ("STAV_ID_STAV")
	  REFERENCES "JH"."STAV" ("ID_STAV") ENABLE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "JH_TBS_PERM" ;

  CREATE UNIQUE INDEX "JH"."HRA__IDX" ON "JH"."HRA" ("OBLAST_ID_OBLAST") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "JH_TBS_PERM" ;
--

  CREATE TABLE "JH"."MINA" 
   (	"ID_MINA" NUMBER NOT NULL ENABLE, 
	"X_SOURADNICE" NUMBER, 
	"Y_SOURADNICE" NUMBER, 
	"OBLAST_ID_OBLAST" NUMBER NOT NULL ENABLE, 
	 CONSTRAINT "MINA_PK" PRIMARY KEY ("ID_MINA")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "JH_TBS_PERM"  ENABLE, 
	 CONSTRAINT "MINA_OBLAST_FK" FOREIGN KEY ("OBLAST_ID_OBLAST")
	  REFERENCES "JH"."OBLAST" ("ID_OBLAST") ENABLE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "JH_TBS_PERM" ;

  CREATE OR REPLACE TRIGGER "JH"."TRAD_MINA" 
after DELETE ON MINA 
FOR EACH ROW 
BEGIN
  UPDATE POLE
  SET OZNACENO = 0
  where OBLAST_ID_OBLAST = :old.OBLAST_ID_OBLAST 
  and X_SOURADNICE = :old.X_SOURADNICE
  and Y_SOURADNICE = :old.Y_SOURADNICE;
  
  update HRA
      set POCET_OZNACENYCH_MIN = (select count(*) from pole where OBLAST_ID_OBLAST = :new.OBLAST_ID_OBLAST AND OZNACENO = 1)
    where OBLAST_ID_OBLAST = :new.OBLAST_ID_OBLAST;
END;
/
ALTER TRIGGER "JH"."TRAD_MINA" ENABLE;

  CREATE OR REPLACE TRIGGER "JH"."TRBI_MINA" 
BEFORE INSERT ON MINA 
FOR EACH ROW
BEGIN
  if MNOHO_MIN(:new.OBLAST_ID_OBLAST) = 0 then
    UPDATE POLE
    SET OZNACENO = 1
    where OBLAST_ID_OBLAST = :new.OBLAST_ID_OBLAST 
    and X_SOURADNICE = :new.X_SOURADNICE
    and Y_SOURADNICE = :new.Y_SOURADNICE;
    
    update HRA
      set POCET_OZNACENYCH_MIN = (select count(*) from pole where OBLAST_ID_OBLAST = :new.OBLAST_ID_OBLAST AND OZNACENO = 1)
    where OBLAST_ID_OBLAST = :new.OBLAST_ID_OBLAST;
  else 
    raise_application_error (-20099,'Nelze oznaèit více zaminovaných polí, než kolik min je v oblasti. ');
    --DBMS_OUTPUT.PUT_LINE('Nelze oznaèit více zaminovaných polí, než kolik min je v oblasti. ');
  end if;

END;
/
ALTER TRIGGER "JH"."TRBI_MINA" ENABLE;
--omezeni

  CREATE TABLE "JH"."OMEZENI" 
   (	"ID_OMEZENI" NUMBER NOT NULL ENABLE, 
	"MIN" NUMBER NOT NULL ENABLE, 
	"MAX" NUMBER NOT NULL ENABLE, 
	"MAX_PROCENT_MIN" NUMBER NOT NULL ENABLE, 
	 CONSTRAINT "OMEZENI_PK" PRIMARY KEY ("ID_OMEZENI")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "JH_TBS_PERM"  ENABLE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "JH_TBS_PERM" ;
--pole

  CREATE TABLE "JH"."POLE" 
   (	"ID_POLE" NUMBER NOT NULL ENABLE, 
	"X_SOURADNICE" NUMBER, 
	"Y_SOURADNICE" NUMBER, 
	"OBSAH" VARCHAR2(1 BYTE), 
	"ODKRYTO" NUMBER(*,0) NOT NULL ENABLE, 
	"OBLAST_ID_OBLAST" NUMBER NOT NULL ENABLE, 
	"OZNACENO" NUMBER(1,0), 
	 CONSTRAINT "POLE_PK" PRIMARY KEY ("ID_POLE")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "JH_TBS_PERM"  ENABLE, 
	 CONSTRAINT "POLE_OBLAST_FK" FOREIGN KEY ("OBLAST_ID_OBLAST")
	  REFERENCES "JH"."OBLAST" ("ID_OBLAST") ENABLE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "JH_TBS_PERM" ;
--tah

  CREATE TABLE "JH"."TAH" 
   (	"ID_TAH" NUMBER NOT NULL ENABLE, 
	"X_SOURADNICE" NUMBER, 
	"Y_SOURADNICE" NUMBER, 
	"CAS" DATE, 
	"OBLAST_ID_OBLAST" NUMBER NOT NULL ENABLE, 
	 CONSTRAINT "TAH_PK" PRIMARY KEY ("ID_TAH")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "JH_TBS_PERM"  ENABLE, 
	 CONSTRAINT "TAH_OBLAST_FK" FOREIGN KEY ("OBLAST_ID_OBLAST")
	  REFERENCES "JH"."OBLAST" ("ID_OBLAST") ENABLE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "JH_TBS_PERM" ;

  CREATE OR REPLACE TRIGGER "JH"."TRBI_TAH" 
BEFORE INSERT ON TAH 
FOR EACH ROW
declare
 bln_oznaceno number(1);
BEGIN
  begin
    select pole.oznaceno into bln_oznaceno from pole 
      inner join hra on pole.OBLAST_ID_OBLAST = hra.OBLAST_ID_OBLAST
      where pole.OBLAST_ID_OBLAST = :new.OBLAST_ID_OBLAST
        and X_SOURADNICE = :new.X_SOURADNICE
        and Y_SOURADNICE = :new.Y_SOURADNICE 
        and hra.STAV_ID_STAV = 1;
  exception when no_data_found then
    raise_application_error (-20098,'Nelze odkrýt pole. Tato hra byla dokonèena.');
  end;
  if bln_oznaceno = 1 then
   raise_application_error (-20098,'Nelze odkrýt pole ozaèené jako mina. ');
  end if;
  
END;
/
ALTER TRIGGER "JH"."TRBI_TAH" ENABLE;

  CREATE OR REPLACE TRIGGER "JH"."TRAI_TAH" 
AFTER INSERT ON TAH 
FOR EACH ROW
declare
bln_prvni_tah number;
BEGIN
  begin
    select 1 into bln_prvni_tah from hra where OBLAST_ID_OBLAST = :new.OBLAST_ID_OBLAST and PRVNI_TAH is null;
    if bln_prvni_tah = 1 then
      update hra
      set PRVNI_TAH = sysdate
      where OBLAST_ID_OBLAST = :new.OBLAST_ID_OBLAST;
    end if;
  EXCEPTION WHEN NO_DATA_FOUND THEN
    null;
  end;
  ODKRYJ_POLE(:new.OBLAST_ID_OBLAST,:new.X_SOURADNICE,:new.Y_SOURADNICE);
  if VYHRA(:new.OBLAST_ID_OBLAST)= 1 then
        update HRA
        set POSLEDNI_TAH = sysdate
        ,STAV_ID_STAV = 2
        where OBLAST_ID_OBLAST = :new.OBLAST_ID_OBLAST;
        DBMS_OUTPUT.put_line('Vyhral jsi.');
        
        OZNAC_MINY( :new.OBLAST_ID_OBLAST);
  end if;
END;
/
ALTER TRIGGER "JH"."TRAI_TAH" ENABLE;
--SEQUENCES

   CREATE SEQUENCE  "JH"."SEQ_HRA"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 61 CACHE 20 NOORDER  NOCYCLE ;

   CREATE SEQUENCE  "JH"."SEQ_MINA"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 41 CACHE 20 NOORDER  NOCYCLE ;

   CREATE SEQUENCE  "JH"."SEQ_OBLAST"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 41 CACHE 20 NOORDER  NOCYCLE ;

   CREATE SEQUENCE  "JH"."SEQ_POLE"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 3421 CACHE 20 NOORDER  NOCYCLE ;

   CREATE SEQUENCE  "JH"."SEQ_TAH"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 161 CACHE 20 NOORDER  NOCYCLE ;

----VIEWS

  CREATE OR REPLACE FORCE VIEW "JH"."CHYBNE_MINY" ("X_SOURADNICE", "Y_SOURADNICE", "OBLAST_ID_OBLAST") AS 
  select pole.X_SOURADNICE,pole.Y_SOURADNICE,pole.OBLAST_ID_OBLAST 
  from pole inner join mina on pole.OBLAST_ID_OBLAST = mina.OBLAST_ID_OBLAST 
    and pole.X_SOURADNICE = mina.X_SOURADNICE
    and pole.Y_SOURADNICE = mina.Y_SOURADNICE
    and pole.obsah <> '!';


  CREATE OR REPLACE FORCE VIEW "JH"."OBLAST_TISK" ("SLOUPEC", "OBLAST_ID") AS 
  select
radek as sloupec,
OBLAST_ID_OBLAST
from(
select distinct Y_SOURADNICE, radek_oblasti( Y_SOURADNICE,pole.OBLAST_ID_OBLAST) radek,pole.OBLAST_ID_OBLAST from pole
order by Y_SOURADNICE);


  CREATE OR REPLACE FORCE VIEW "JH"."PORAZENI" ("ID_HRA", "PRVNI_TAH", "POSLEDNI_TAH", "OBTIZNOST", "SPRAVNE_MINY") AS 
  select hra.id_hra,HRA.prvni_tah,HRA.POSLEDNI_TAH,nvl(obtiznost.nazev,'Vlastni') obtiznost,nvl(spravne_miny,0) spravne_miny
  from hra inner join oblast on hra.OBLAST_ID_OBLAST =oblast.ID_OBLAST 
  left join obtiznost on oblast.obtiznost_id_obtiznost = obtiznost.id_obtiznost
  left join
 (select HRA.ID_HRA,POCET_OZNACENYCH_MIN - count(id_hra) spravne_miny
  from hra 
    inner join CHYBNE_MINY on hra.OBLAST_ID_OBLAST = CHYBNE_MINY.OBLAST_ID_OBLAST
  where stav_id_stav = 3
  group by HRA.ID_HRA,POCET_OZNACENYCH_MIN) temp on temp.ID_HRA = HRA.ID_HRA
  where stav_id_stav = 3
  order by HRA.id_hra;


  CREATE OR REPLACE FORCE VIEW "JH"."VITEZOVE" ("PRVNI_TAH", "POSLEDNI_TAH", "OBTIZNOST") AS 
  select prvni_tah,POSLEDNI_TAH,nvl(obtiznost.nazev,'Vlastni') obtiznost 
from hra inner join oblast on hra.OBLAST_ID_OBLAST =oblast.ID_OBLAST 
left join obtiznost on oblast.obtiznost_id_obtiznost = obtiznost.id_obtiznost
where stav_id_stav = 2;
----PROCEDURES
create or replace PROCEDURE ODKRYJ_POLE 
(
  OBLAST_ID IN NUMBER 
, X IN NUMBER 
, Y IN NUMBER 
) AS 
bln_odkryto number(1);
BEGIN
  begin
    select 1 into bln_odkryto from pole where OBLAST_ID_OBLAST=OBLAST_ID AND X_SOURADNICE = X AND Y_SOURADNICE = Y AND ODKRYTO = 0;
      update pole set ODKRYTO = 1 WHERE OBLAST_ID_OBLAST=OBLAST_ID AND X_SOURADNICE = X AND Y_SOURADNICE = Y;
      if ODKRYTA_MINA(OBLAST_ID,X,Y) = 1 then
       update HRA
       set POSLEDNI_TAH = sysdate
        ,STAV_ID_STAV = 3
        where OBLAST_ID_OBLAST = OBLAST_ID;
        DBMS_OUTPUT.put_line('Prohral jsi.');
--      elsif VYHRA(OBLAST_ID)= 1 then
--        update HRA
--        set POSLEDNI_TAH = sysdate
--        ,STAV_ID_STAV = 2
--        where OBLAST_ID_OBLAST = OBLAST_ID;
--        DBMS_OUTPUT.put_line('Vyhral jsi.');
      elsif PRAZDNE(OBLAST_ID,X,Y)= 1 then
        ODKRYJ_POLE(OBLAST_ID,X,Y);
      end if;      
  exception when no_data_found then
    null;
  end;
  if PRAZDNE(OBLAST_ID,X,Y)= 1 then
    begin
      select 1 into bln_odkryto from pole where OBLAST_ID_OBLAST=OBLAST_ID AND X_SOURADNICE = X-1 AND Y_SOURADNICE = Y+1 AND ODKRYTO = 0 and OBSAH<>'!';
      update pole set ODKRYTO = 1 WHERE OBLAST_ID_OBLAST=OBLAST_ID AND X_SOURADNICE = X-1 AND Y_SOURADNICE = Y+1;
      if PRAZDNE(OBLAST_ID,X-1,Y+1)= 1 then
        ODKRYJ_POLE(OBLAST_ID,X-1,Y+1);
      end if;
    exception when no_data_found then
      null;
    end;
    
    begin
      select 1 into bln_odkryto from pole where OBLAST_ID_OBLAST=OBLAST_ID AND X_SOURADNICE = X-1 AND Y_SOURADNICE = Y AND ODKRYTO = 0 and OBSAH<>'!';
      update pole set ODKRYTO = 1 WHERE OBLAST_ID_OBLAST=OBLAST_ID AND X_SOURADNICE = X-1 AND Y_SOURADNICE = Y;
      if PRAZDNE(OBLAST_ID,X-1,Y)= 1 then
        ODKRYJ_POLE(OBLAST_ID,X-1,Y);
      end if;
    exception when no_data_found then
      null;
    end;
    
    begin
      select 1 into bln_odkryto from pole where OBLAST_ID_OBLAST=OBLAST_ID AND X_SOURADNICE = X-1 AND Y_SOURADNICE = Y-1 AND ODKRYTO = 0 and OBSAH<>'!';
      update pole set ODKRYTO = 1 WHERE OBLAST_ID_OBLAST=OBLAST_ID AND X_SOURADNICE = X-1 AND Y_SOURADNICE = Y-1;
      if PRAZDNE(OBLAST_ID,X-1,Y-1)= 1 then
        ODKRYJ_POLE(OBLAST_ID,X-1,Y-1);
      end if;
    exception when no_data_found then
      null;
    end;
    
    begin
      select 1 into bln_odkryto from pole where OBLAST_ID_OBLAST=OBLAST_ID AND X_SOURADNICE = X AND Y_SOURADNICE = Y-1 AND ODKRYTO = 0 and OBSAH<>'!';
      update pole set ODKRYTO = 1 WHERE OBLAST_ID_OBLAST=OBLAST_ID AND X_SOURADNICE = X AND Y_SOURADNICE = Y-1;
      if PRAZDNE(OBLAST_ID,X,Y-1)= 1 then
        ODKRYJ_POLE(OBLAST_ID,X,Y-1);
      end if;
    exception when no_data_found then
      null;
    end;
    
    begin
      select 1 into bln_odkryto from pole where OBLAST_ID_OBLAST=OBLAST_ID AND X_SOURADNICE = X+1 AND Y_SOURADNICE = Y-1 AND ODKRYTO = 0 and OBSAH<>'!';
      update pole set ODKRYTO = 1 WHERE OBLAST_ID_OBLAST=OBLAST_ID AND X_SOURADNICE = X+1 AND Y_SOURADNICE = Y-1;
      if PRAZDNE(OBLAST_ID,X+1,Y-1)= 1 then
        ODKRYJ_POLE(OBLAST_ID,X+1,Y-1);
      end if;
    exception when no_data_found then
      null;
    end;
    
    begin
      select 1 into bln_odkryto from pole where OBLAST_ID_OBLAST=OBLAST_ID AND X_SOURADNICE = X+1 AND Y_SOURADNICE = Y AND ODKRYTO = 0 and OBSAH<>'!';
      update pole set ODKRYTO = 1 WHERE OBLAST_ID_OBLAST=OBLAST_ID AND X_SOURADNICE = X+1 AND Y_SOURADNICE = Y;
      if PRAZDNE(OBLAST_ID,X+1,Y)= 1 then
        ODKRYJ_POLE(OBLAST_ID,X+1,Y);
      end if;
    exception when no_data_found then
      null;
    end;
  
    begin
      select 1 into bln_odkryto from pole where OBLAST_ID_OBLAST=OBLAST_ID AND X_SOURADNICE = X+1 AND Y_SOURADNICE = Y+1 AND ODKRYTO = 0 and OBSAH<>'!';
      update pole set ODKRYTO = 1 WHERE OBLAST_ID_OBLAST=OBLAST_ID AND X_SOURADNICE = X+1 AND Y_SOURADNICE = Y+1;
      if PRAZDNE(OBLAST_ID,X+1,Y+1)= 1 then
        ODKRYJ_POLE(OBLAST_ID,X+1,Y+1);
      end if;
    exception when no_data_found then
      null;
    end;
    
    begin
      select 1 into bln_odkryto from pole where OBLAST_ID_OBLAST=OBLAST_ID AND X_SOURADNICE = X AND Y_SOURADNICE = Y+1 AND ODKRYTO = 0 and OBSAH<>'!';
      update pole set ODKRYTO = 1 WHERE OBLAST_ID_OBLAST=OBLAST_ID AND X_SOURADNICE = X AND Y_SOURADNICE = Y+1;
      if PRAZDNE(OBLAST_ID,X,Y+1)= 1 then
        ODKRYJ_POLE(OBLAST_ID,X,Y+1);
      end if;
    exception when no_data_found then
      null;
    end;
  end if;
END;

create or replace PROCEDURE OZNAC_MINY 
(
  OBLAST_ID NUMBER
) AS 
BEGIN
  update pole
  set oznaceno = 1
  where OBLAST_ID_OBLAST = OBLAST_ID and obsah = '!';
END;

create or replace PROCEDURE SPOCITEJ_OBLAST 
(
  OBLAST_ID NUMBER,
  RADKY NUMBER,
  SLOUPCE NUMBER
  --x IN NUMBER,
 -- y IN NUMBER
) AS
bln_mina number;
pocet_min number;

BEGIN
  FOR y IN 1..SLOUPCE LOOP
    FOR x IN 1..RADKY LOOP
      pocet_min :=0;
      begin
        SELECT case obsah when '!' then 1 else 0 end into bln_mina
          FROM POLE WHERE OBLAST_ID_OBLAST = OBLAST_ID
          AND X_SOURADNICE = x-1
          and y_souradnice = y;
      exception when NO_DATA_FOUND then
        bln_mina := 0;
      end;
      pocet_min := pocet_min+ bln_mina; 
      begin
        SELECT case obsah when '!' then 1 else 0 end into bln_mina
          FROM POLE WHERE OBLAST_ID_OBLAST = OBLAST_ID
          AND X_SOURADNICE = x-1
          and y_souradnice = y-1;
            exception when NO_DATA_FOUND then
        bln_mina := 0;
      end;
      pocet_min := pocet_min+ bln_mina; 
      begin
        SELECT case obsah when '!' then 1 else 0 end into bln_mina
          FROM POLE WHERE OBLAST_ID_OBLAST = OBLAST_ID
          AND X_SOURADNICE = x
          and y_souradnice = y-1;
      exception when NO_DATA_FOUND then
        bln_mina := 0;
      end;
      pocet_min := pocet_min+ bln_mina;
      begin
      SELECT case obsah when '!' then 1 else 0 end into bln_mina
        FROM POLE WHERE OBLAST_ID_OBLAST = OBLAST_ID
        AND X_SOURADNICE = x+1
        and y_souradnice = y-1;
      exception when NO_DATA_FOUND then
        bln_mina := 0;
      end;
      pocet_min := pocet_min+ bln_mina;
      begin
        SELECT case obsah when '!' then 1 else 0 end into bln_mina
          FROM POLE WHERE OBLAST_ID_OBLAST = OBLAST_ID
          AND X_SOURADNICE = x+1
          and y_souradnice = y;
      exception when NO_DATA_FOUND then
        bln_mina := 0;
      end;
      pocet_min := pocet_min+ bln_mina; 
      begin
        SELECT case obsah when '!' then 1 else 0 end into bln_mina
          FROM POLE WHERE OBLAST_ID_OBLAST = OBLAST_ID
          AND X_SOURADNICE = x+1
          and y_souradnice = y+1;
      exception when NO_DATA_FOUND then
        bln_mina := 0;
      end;
      pocet_min := pocet_min+ bln_mina; 
      begin
      SELECT case obsah when '!' then 1 else 0 end into bln_mina
        FROM POLE WHERE OBLAST_ID_OBLAST = OBLAST_ID
        AND X_SOURADNICE = x
        and y_souradnice = y+1;
      exception when NO_DATA_FOUND then
        bln_mina := 0;
      end;
      pocet_min := pocet_min+ bln_mina;
      begin
        SELECT case obsah when '!' then 1 else 0 end into bln_mina
        FROM POLE WHERE OBLAST_ID_OBLAST = OBLAST_ID
        AND X_SOURADNICE = x-1
        and y_souradnice = y+1;
      exception when NO_DATA_FOUND then
        bln_mina := 0;
      end;
      pocet_min := pocet_min+ bln_mina; 
      
      update pole 
       set obsah = pocet_min
       WHERE OBLAST_ID_OBLAST = OBLAST_ID
        AND X_SOURADNICE = x
        and y_souradnice = y
        and OBSAH != '!';
    END LOOP;  
  END LOOP; 
END SPOCITEJ_OBLAST;

create or replace PROCEDURE VYTVOR_VLASTNI_HRU 
(
  radky NUMBER,
  sloupce NUMBER,
  pocet_min NUMBER
) AS 

BEGIN
  if SPATNY_PARAMETR(radky,sloupce,pocet_min) = 1 then
   raise_application_error (-20097,'Definice vlastni hry neodpovida omezeni. (Spatny parametr) ');
  else
    insert into oblast (ID_OBLAST,SLOUPCE,RADKY,POCET_MIN) values(seq_oblast.nextval,SLOUPCE,RADKY,POCET_MIN);
  end if;
END;

create or replace PROCEDURE VYTVOR_ZAKLADNI_HRU 
(
  OBTIZNOST_ID NUMBER
) AS 
radky number;
sloupce number;
pocet_min number;
BEGIN
  select RADKY,SLOUPCE,POCET_MIN into RADKY,SLOUPCE,POCET_MIN from OBTIZNOST where ID_OBTIZNOST = OBTIZNOST_ID;
  insert into oblast values(seq_oblast.nextval,SLOUPCE,RADKY,POCET_MIN,OBTIZNOST_ID);
END;

create or replace PROCEDURE ZAMINUJ_OBLAST 
(
  OBLAST_ID NUMBER,
  x_vel IN NUMBER,
  y_vel IN NUMBER,
  pocet_min in number
) AS 
zaminuj_x number;
zaminuj_y number;
mina_uz_existuje number;
BEGIN
  FOR m IN 1..pocet_min LOOP
    LOOP
      select round(DBMS_Random.Value(1,x_vel)),round(DBMS_Random.Value(1,y_vel)) into zaminuj_x,zaminuj_y from dual;
      select case when OBSAH='!' then 1 else 0 end into mina_uz_existuje from pole
        where OBLAST_ID_OBLAST = OBLAST_ID 
        and X_SOURADNICE = zaminuj_x
        and Y_SOURADNICE = zaminuj_y
      ;
      EXIT WHEN mina_uz_existuje = 0;
    END LOOP;  
    
  --  SYS.DBMS_OUTPUT.PUT_LINE('minaX-'|| zaminuj_x);
  --  SYS.DBMS_OUTPUT.PUT_LINE('minaY-'|| zaminuj_y);
    
    update pole 
    set obsah = '!'
    where OBLAST_ID_OBLAST = OBLAST_ID 
        and X_SOURADNICE = zaminuj_x
        and Y_SOURADNICE = zaminuj_y
      ;
  END LOOP; 
END ZAMINUJ_OBLAST;
--FUNCTIONS
create or replace FUNCTION MNOHO_MIN 
(
  OBLAST_ID IN NUMBER 
) RETURN NUMBER AS  
ln_pocet_min number;
ln_pocet_ozn_min number;
BEGIN
  begin
    select count(*)into ln_pocet_ozn_min from pole where OBLAST_ID_OBLAST = OBLAST_ID
      and oznaceno = 1;
  exception when no_data_found then
    ln_pocet_ozn_min := 0;
  end;
  
  select POCET_MIN into ln_pocet_min from OBLAST where ID_OBLAST = OBLAST_ID;
  
  if ln_pocet_min = ln_pocet_ozn_min then 
    return 1;
  else
    return 0;
  end if;
END;

create or replace FUNCTION ODKRYTA_MINA 
(
  OBLAST_ID IN NUMBER 
, X IN NUMBER 
, Y IN NUMBER 
) RETURN number AS 
bln_mina number;
BEGIN
  bln_mina := 0;
  select case obsah when '!' then 1 else 0 end into bln_mina from pole where OBLAST_ID_OBLAST = oblast_id and X_SOURADNICE = x and Y_SOURADNICE = y;
  RETURN bln_mina;
END ODKRYTA_MINA;

create or replace FUNCTION PRAZDNE 
(
  OBLAST_ID IN NUMBER 
, X IN NUMBER 
, Y IN NUMBER 
) RETURN number AS 
bln_prazdne number;
BEGIN
  bln_prazdne := 0;
  begin
    select case obsah when '0' then 1 else 0 end into bln_prazdne from pole
      where OBLAST_ID_OBLAST = oblast_id 
      and X_SOURADNICE = x 
      and Y_SOURADNICE = y
      ;
  exception when no_data_found then
   bln_prazdne := 0;
  end;
--  DBMS_OUTPUT.PUT_LINE(x||'-'||y||' bln_prazdne -'||bln_prazdne);
  RETURN bln_prazdne;
END;

create or replace FUNCTION RADEK_OBLASTI(radek in Number,oblast_id number)
return VARCHAR2 is
ret varchar2(255);
begin 
  ret:='';
  FOR c IN (SELECT obsah,odkryto,oznaceno
            FROM pole 
            where Y_SOURADNICE = radek and OBLAST_ID_OBLAST = oblast_id) LOOP
    
    if c.odkryto = 0 and c.oznaceno = 0 then
      ret := ret || '?|';
    elsif c.oznaceno = 1 then
      ret := ret || 'm|';
    elsif c.odkryto = 1 and c.obsah = '0' then
      ret := ret || ' |';
    else
      ret := ret ||c.obsah||'|';
    end if;
  END LOOP;
--  DBMS_OUTPUT.PUT_LINE(ret);
  return ret;
end;

create or replace FUNCTION SPATNY_PARAMETR 
(
  radky NUMBER,
  sloupce NUMBER,
  pocet_min NUMBER
) RETURN NUMBER AS  
bln_Nok number(1);
BEGIN

  begin
  select 1 into bln_Nok from OMEZENI 
    where radky not between min and max
      or sloupce not between min and max
      or pocet_min/(radky*sloupce)*100 > MAX_PROCENT_MIN
    ;  
  exception when no_data_found then
    bln_Nok:= 0;
  end;
  
  return bln_Nok;
END;

create or replace FUNCTION vyhra 
(
  OBLAST_ID IN NUMBER 
) RETURN number AS 
bln_vyhra number;
ln_pocet_neodkrytych number;
--ln_pocet_min number;
BEGIN
  bln_vyhra := 0;
  select count(*) into ln_pocet_neodkrytych from pole where OBLAST_ID_OBLAST = oblast_id and ODKRYTO = 0 and OBSAH <> '!';
  --select POCET_MIN into ln_pocet_min from oblast where ID_OBLAST = OBLAST_ID;
  if ln_pocet_neodkrytych =0 then
    bln_vyhra := 1;
  end if;
  RETURN bln_vyhra;
END vyhra;
