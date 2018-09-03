USE NETFLIX
GO
CREATE
  TABLE dbo.CAT_USER
  (
    ID_USER  INTEGER NOT NULL IDENTITY NOT FOR REPLICATION ,
    USERNAME VARCHAR (25) NOT NULL ,
    PASSWORD VARCHAR (10) ,
    ACTIVE BIT DEFAULT 1 ,
    LOAD_USER   VARCHAR (25) NOT NULL ,
    LOAD_DATE   DATETIME NOT NULL ,
    UPDATE_USER VARCHAR (25) NOT NULL ,
    UPDATE_DATE DATETIME NOT NULL
  )
  ON "PRIMARY" TEXTIMAGE_ON 'PRIMARY'
GO
EXEC sp_addextendedproperty 'MS_Description' ,
'Llave primaria de la tabla de usuarios.' ,
'SCHEMA' ,
'dbo' ,
'TABLE' ,
'CAT_USER' ,
'COLUMN' ,
'ID_USER'
GO
EXEC sp_addextendedproperty 'MS_Description' ,
'Nombre del usuario' ,
'SCHEMA' ,
'dbo' ,
'TABLE' ,
'CAT_USER' ,
'COLUMN' ,
'USERNAME'
GO
EXEC sp_addextendedproperty 'MS_Description' ,
'Contraseña del usuario' ,
'SCHEMA' ,
'dbo' ,
'TABLE' ,
'CAT_USER' ,
'COLUMN' ,
'PASSWORD'
GO
EXEC sp_addextendedproperty 'MS_Description' ,
'Indica si el usuario está activo.' ,
'SCHEMA' ,
'dbo' ,
'TABLE' ,
'CAT_USER' ,
'COLUMN' ,
'ACTIVE'
GO
EXEC sp_addextendedproperty 'MS_Description' ,
'Usuario realizó la alta en el catálogo' ,
'SCHEMA' ,
'dbo' ,
'TABLE' ,
'CAT_USER' ,
'COLUMN' ,
'LOAD_USER'
GO
EXEC sp_addextendedproperty 'MS_Description' ,
'Fecha de carga en el catálogo.' ,
'SCHEMA' ,
'dbo' ,
'TABLE' ,
'CAT_USER' ,
'COLUMN' ,
'LOAD_DATE'
GO
EXEC sp_addextendedproperty 'MS_Description' ,
'Usuario realizó modificación en el catálogo' ,
'SCHEMA' ,
'dbo' ,
'TABLE' ,
'CAT_USER' ,
'COLUMN' ,
'UPDATE_USER'
GO
EXEC sp_addextendedproperty 'MS_Description' ,
'Fecha de actualización en el catálogo.' ,
'SCHEMA' ,
'dbo' ,
'TABLE' ,
'CAT_USER' ,
'COLUMN' ,
'UPDATE_DATE'
GO
CREATE NONCLUSTERED INDEX
USERNAME_PASSWORD_IDX ON dbo.CAT_USER
(
  USERNAME ,
  PASSWORD
)
ON "default"
GO
CREATE UNIQUE INDEX CAT_USER_ID_USER_IDX ON dbo.CAT_USER
(
  ID_USER ASC
)

CREATE TABLE dbo.CAT_USER_JN
 (JN_OPERATION CHAR(3) NOT NULL
 ,JN_ORACLE_USER VARCHAR2(30) NOT NULL
 ,JN_DATETIME DATE NOT NULL
 ,JN_NOTES VARCHAR2(240)
 ,JN_APPLN VARCHAR2(35)
 ,JN_SESSION NUMBER(38)
 ,ID_USER INTEGER NOT NULL
 ,USERNAME VARCHAR (25) NOT NULL
 ,PASSWORD VARCHAR (10)
 ,ACTIVE BIT
 ,LOAD_USER VARCHAR (25) NOT NULL
 ,LOAD_DATE DATETIME NOT NULL
 ,UPDATE_USER VARCHAR (25) NOT NULL
 ,UPDATE_DATE DATETIME NOT NULL
 );

CREATE OR REPLACE TRIGGER dbo.CAT_USER_JNtrg
  AFTER 
  INSERT OR 
  UPDATE OR 
  DELETE ON dbo.CAT_USER for each row 
 Declare 
  rec dbo.CAT_USER_JN%ROWTYPE; 
  blank dbo.CAT_USER_JN%ROWTYPE; 
  BEGIN 
    rec := blank; 
    IF INSERTING OR UPDATING THEN 
      rec.ID_USER := :NEW.ID_USER; 
      rec.USERNAME := :NEW.USERNAME; 
      rec.PASSWORD := :NEW.PASSWORD; 
      rec.ACTIVE := :NEW.ACTIVE; 
      rec.LOAD_USER := :NEW.LOAD_USER; 
      rec.LOAD_DATE := :NEW.LOAD_DATE; 
      rec.UPDATE_USER := :NEW.UPDATE_USER; 
      rec.UPDATE_DATE := :NEW.UPDATE_DATE; 
      rec.JN_DATETIME := SYSDATE; 
      rec.JN_ORACLE_USER := SYS_CONTEXT ('USERENV', 'SESSION_USER'); 
      rec.JN_APPLN := SYS_CONTEXT ('USERENV', 'MODULE'); 
      rec.JN_SESSION := SYS_CONTEXT ('USERENV', 'SESSIONID'); 
      IF INSERTING THEN 
        rec.JN_OPERATION := 'INS'; 
      ELSIF UPDATING THEN 
        rec.JN_OPERATION := 'UPD'; 
      END IF; 
    ELSIF DELETING THEN 
      rec.ID_USER := :OLD.ID_USER; 
      rec.USERNAME := :OLD.USERNAME; 
      rec.PASSWORD := :OLD.PASSWORD; 
      rec.ACTIVE := :OLD.ACTIVE; 
      rec.LOAD_USER := :OLD.LOAD_USER; 
      rec.LOAD_DATE := :OLD.LOAD_DATE; 
      rec.UPDATE_USER := :OLD.UPDATE_USER; 
      rec.UPDATE_DATE := :OLD.UPDATE_DATE; 
      rec.JN_DATETIME := SYSDATE; 
      rec.JN_ORACLE_USER := SYS_CONTEXT ('USERENV', 'SESSION_USER'); 
      rec.JN_APPLN := SYS_CONTEXT ('USERENV', 'MODULE'); 
      rec.JN_SESSION := SYS_CONTEXT ('USERENV', 'SESSIONID'); 
      rec.JN_OPERATION := 'DEL'; 
    END IF; 
    INSERT into dbo.CAT_USER_JN VALUES rec; 
  END; 
  /