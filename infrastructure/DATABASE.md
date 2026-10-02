# Base de datos y migraciones

La aplicación usa PostgreSQL y ejecuta automáticamente las migraciones de
`src/main/resources/db/migration` al iniciar. El esquema predeterminado es
`librarydb_schema` y el historial queda en
`librarydb_schema.flyway_schema_history_librarydb`.

## Variables de conexión

Los valores locales predeterminados están en `application-dev.yml`. Para no
guardar credenciales de otros ambientes en Git, se pueden sobrescribir así:

```powershell
$env:DB_URL = 'jdbc:postgresql://localhost:5432/librarydb'
$env:DB_USERNAME = 'daniel'
$env:DB_PASSWORD = 'su-clave'
$env:DB_SCHEMA = 'librarydb_schema'
mvn -pl infrastructure spring-boot:run
```

## DBeaver

Configure una conexión PostgreSQL con los mismos host, puerto, base de datos,
usuario y contraseña. Después de iniciar la aplicación:

1. Refresque la conexión con `F5`.
2. Abra `Databases > librarydb > Schemas > librarydb_schema > Tables`.
3. Deben aparecer 52 tablas del modelo y la tabla de historial de Flyway.

Estas consultas permiten comprobarlo desde el editor SQL de DBeaver:

```sql
SELECT version, description, installed_on, success
FROM librarydb_schema.flyway_schema_history_librarydb
ORDER BY installed_rank;

SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'librarydb_schema'
  AND table_type = 'BASE TABLE'
ORDER BY table_name;
```

Si PostgreSQL responde `demasiadas conexiones para el rol`, un administrador
debe revisar las sesiones y el límite del rol:

```sql
SELECT rolname, rolconnlimit
FROM pg_roles
WHERE rolname = 'daniel';

SELECT pid, usename, datname, application_name, state
FROM pg_stat_activity
WHERE usename = 'daniel';

ALTER ROLE daniel CONNECTION LIMIT 10;
```

El `ALTER ROLE` requiere un usuario administrador y solo es necesario si
`rolconnlimit` es demasiado bajo.
