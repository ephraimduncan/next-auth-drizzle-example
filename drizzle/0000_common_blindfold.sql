CREATE TABLE IF NOT EXISTS "Account" (
	"id" text PRIMARY KEY NOT NULL,
	"userId" varchar NOT NULL,
	"type" varchar NOT NULL,
	"provider" varchar NOT NULL,
	"providerAccountId" varchar NOT NULL,
	"refresh_token" varchar,
	"access_token" varchar,
	"expires_at" timestamp,
	"token_type" varchar,
	"scope" varchar,
	"id_token" varchar,
	"session_state" varchar
);

CREATE TABLE IF NOT EXISTS "Session" (
	"id" text PRIMARY KEY NOT NULL,
	"sessionToken" varchar NOT NULL,
	"userId" varchar NOT NULL,
	"expires" timestamp NOT NULL
);

CREATE TABLE IF NOT EXISTS "User" (
	"id" text PRIMARY KEY NOT NULL,
	"name" varchar,
	"email" varchar,
	"emailVerified" timestamp,
	"image" varchar
);

CREATE TABLE IF NOT EXISTS "VerificationToken" (
	"token" varchar NOT NULL,
	"identifier" varchar NOT NULL,
	"expires" timestamp NOT NULL
);

DO $$ BEGIN
 ALTER TABLE "Account" ADD CONSTRAINT "Account_userId_User_id_fk" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;

DO $$ BEGIN
 ALTER TABLE "Session" ADD CONSTRAINT "Session_userId_User_id_fk" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;

CREATE UNIQUE INDEX IF NOT EXISTS "Account_provider_providerAccountId_key" ON "Account" ("provider","providerAccountId");
CREATE UNIQUE INDEX IF NOT EXISTS "Session_sessionToken_key" ON "Session" ("sessionToken");
CREATE UNIQUE INDEX IF NOT EXISTS "User_email_key" ON "User" ("email");
CREATE UNIQUE INDEX IF NOT EXISTS "VerificationToken_token_key" ON "VerificationToken" ("token");
CREATE UNIQUE INDEX IF NOT EXISTS "VerificationToken_identifier_key" ON "VerificationToken" ("identifier");