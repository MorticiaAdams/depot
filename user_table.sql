CREATE TABLE "users" (
"id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
"name" varchar,
"created_at" datetime NOT NULL,
"updated_at" datetime NOT NULL,
"last_visit" datetime,
"email" varchar,
"salt" varchar,
"encrypted_password" varchar DEFAULT '' NOT NULL,
"reset_password_token" varchar,
"reset_password_sent_at" datetime,
"remember_created_at" datetime,
"sign_in_count" integer DEFAULT 0 NOT NULL,
"current_sign_in_at" datetime,
"last_sign_in_at" datetime,
"current_sign_in_ip" varchar,
"last_sign_in_ip" varchar,
"role_id" integer);

CREATE UNIQUE INDEX "index_users_on_email" ON "users" ("email");
CREATE UNIQUE INDEX "index_users_on_reset_password_token" ON "users" ("reset_password_token");

