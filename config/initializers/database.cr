require "granite_orm/adapter/pg"

if Amber.env.development?
  Process.run(
    "pg_dump #{Amber.settings.database_url} > structure.sql",
    shell: true
  )
end

Granite::ORM.settings.database_url = Amber.settings.database_url
Granite::ORM.settings.logger = Amber.settings.logger.dup
Granite::ORM.settings.logger.progname = "Granite"
