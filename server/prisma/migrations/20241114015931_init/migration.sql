-- CreateTable
CREATE TABLE "users" (
    "user_id" SERIAL NOT NULL,
    "cognito_id" TEXT NOT NULL,
    "username" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "first_name" TEXT NOT NULL,
    "surname" TEXT,
    "profile_pic_url" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "last_login" TIMESTAMP(3),

    CONSTRAINT "users_pkey" PRIMARY KEY ("user_id")
);

-- CreateTable
CREATE TABLE "league" (
    "league_id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "competition_id" INTEGER NOT NULL,
    "description" TEXT,
    "is_private" BOOLEAN NOT NULL DEFAULT false,
    "created_by_id" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "league_pkey" PRIMARY KEY ("league_id")
);

-- CreateTable
CREATE TABLE "user_league" (
    "user_league_id" SERIAL NOT NULL,
    "user_id" INTEGER NOT NULL,
    "league_id" INTEGER NOT NULL,
    "joined_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "user_league_pkey" PRIMARY KEY ("user_league_id")
);

-- CreateTable
CREATE TABLE "competition" (
    "competition_id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "has_winning_team" BOOLEAN NOT NULL DEFAULT true,
    "has_top_tries" BOOLEAN NOT NULL DEFAULT true,
    "has_top_points" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "competition_pkey" PRIMARY KEY ("competition_id")
);

-- CreateIndex
CREATE UNIQUE INDEX "users_cognito_id_key" ON "users"("cognito_id");

-- CreateIndex
CREATE UNIQUE INDEX "users_username_key" ON "users"("username");

-- CreateIndex
CREATE UNIQUE INDEX "users_email_key" ON "users"("email");

-- AddForeignKey
ALTER TABLE "league" ADD CONSTRAINT "league_competition_id_fkey" FOREIGN KEY ("competition_id") REFERENCES "competition"("competition_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "league" ADD CONSTRAINT "league_created_by_id_fkey" FOREIGN KEY ("created_by_id") REFERENCES "users"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_league" ADD CONSTRAINT "user_league_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_league" ADD CONSTRAINT "user_league_league_id_fkey" FOREIGN KEY ("league_id") REFERENCES "league"("league_id") ON DELETE RESTRICT ON UPDATE CASCADE;
