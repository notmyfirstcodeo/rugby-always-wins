-- CreateTable
CREATE TABLE "users" (
    "user_id" SERIAL NOT NULL,
    "cognito_id" TEXT NOT NULL,
    "username" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT,
    "profile_pic_url" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "last_login" TIMESTAMP(3),

    CONSTRAINT "users_pkey" PRIMARY KEY ("user_id")
);

-- CreateTable
CREATE TABLE "league" (
    "league_id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "competition_id" INTEGER NOT NULL,
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

-- CreateTable
CREATE TABLE "match" (
    "match_id" SERIAL NOT NULL,
    "competition_id" INTEGER NOT NULL,
    "home_team_id" INTEGER NOT NULL,
    "away_team_id" INTEGER NOT NULL,
    "stadiumId" INTEGER,
    "match_date" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "match_pkey" PRIMARY KEY ("match_id")
);

-- CreateTable
CREATE TABLE "match_result" (
    "match_result_id" SERIAL NOT NULL,
    "match_id" INTEGER NOT NULL,
    "homeTeamScore" INTEGER,
    "awayTeamScore" INTEGER,
    "point_difference" INTEGER,
    "winnerTeamId" INTEGER,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "last_updated" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "match_result_pkey" PRIMARY KEY ("match_result_id")
);

-- CreateTable
CREATE TABLE "stadium" (
    "stadium_id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "city_id" INTEGER NOT NULL,
    "team_id" INTEGER NOT NULL,

    CONSTRAINT "stadium_pkey" PRIMARY KEY ("stadium_id")
);

-- CreateTable
CREATE TABLE "country" (
    "country_id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "country_pkey" PRIMARY KEY ("country_id")
);

-- CreateTable
CREATE TABLE "city" (
    "city_id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "country_id" INTEGER NOT NULL,

    CONSTRAINT "city_pkey" PRIMARY KEY ("city_id")
);

-- CreateTable
CREATE TABLE "team" (
    "team_id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "team_pkey" PRIMARY KEY ("team_id")
);

-- CreateTable
CREATE TABLE "player" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "team_id" INTEGER NOT NULL,
    "position_id" INTEGER NOT NULL,

    CONSTRAINT "player_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "position" (
    "position_id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "position_pkey" PRIMARY KEY ("position_id")
);

-- CreateTable
CREATE TABLE "match_prediction" (
    "match_prediction_id" SERIAL NOT NULL,
    "user_league_id" INTEGER NOT NULL,
    "match_id" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "predicted_home_score" INTEGER,
    "predicted_away_score" INTEGER,
    "predicted_points_difference" INTEGER,
    "first_try_scorer_id" INTEGER,

    CONSTRAINT "match_prediction_pkey" PRIMARY KEY ("match_prediction_id")
);

-- CreateTable
CREATE TABLE "competition_prediction" (
    "competition_prediction_id" SERIAL NOT NULL,
    "user_league_id" INTEGER NOT NULL,
    "competition_id" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "predicted_winner_id" INTEGER,
    "top_try_scorer_id" INTEGER,
    "top_points_scorer_id" INTEGER,

    CONSTRAINT "competition_prediction_pkey" PRIMARY KEY ("competition_prediction_id")
);

-- CreateTable
CREATE TABLE "point" (
    "points_id" SERIAL NOT NULL,
    "user_league_id" INTEGER NOT NULL,
    "points" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "point_pkey" PRIMARY KEY ("points_id")
);

-- CreateIndex
CREATE UNIQUE INDEX "users_cognito_id_key" ON "users"("cognito_id");

-- CreateIndex
CREATE UNIQUE INDEX "users_username_key" ON "users"("username");

-- CreateIndex
CREATE UNIQUE INDEX "users_email_key" ON "users"("email");

-- CreateIndex
CREATE UNIQUE INDEX "country_name_key" ON "country"("name");

-- CreateIndex
CREATE UNIQUE INDEX "team_name_key" ON "team"("name");

-- CreateIndex
CREATE UNIQUE INDEX "position_name_key" ON "position"("name");

-- AddForeignKey
ALTER TABLE "league" ADD CONSTRAINT "league_competition_id_fkey" FOREIGN KEY ("competition_id") REFERENCES "competition"("competition_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "league" ADD CONSTRAINT "league_created_by_id_fkey" FOREIGN KEY ("created_by_id") REFERENCES "users"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_league" ADD CONSTRAINT "user_league_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_league" ADD CONSTRAINT "user_league_league_id_fkey" FOREIGN KEY ("league_id") REFERENCES "league"("league_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "match" ADD CONSTRAINT "match_home_team_id_fkey" FOREIGN KEY ("home_team_id") REFERENCES "team"("team_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "match" ADD CONSTRAINT "match_away_team_id_fkey" FOREIGN KEY ("away_team_id") REFERENCES "team"("team_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "match" ADD CONSTRAINT "match_competition_id_fkey" FOREIGN KEY ("competition_id") REFERENCES "competition"("competition_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "match" ADD CONSTRAINT "match_stadiumId_fkey" FOREIGN KEY ("stadiumId") REFERENCES "stadium"("stadium_id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "match_result" ADD CONSTRAINT "match_result_match_id_fkey" FOREIGN KEY ("match_id") REFERENCES "match"("match_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "stadium" ADD CONSTRAINT "stadium_city_id_fkey" FOREIGN KEY ("city_id") REFERENCES "city"("city_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "stadium" ADD CONSTRAINT "stadium_team_id_fkey" FOREIGN KEY ("team_id") REFERENCES "team"("team_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "city" ADD CONSTRAINT "city_country_id_fkey" FOREIGN KEY ("country_id") REFERENCES "country"("country_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "player" ADD CONSTRAINT "player_team_id_fkey" FOREIGN KEY ("team_id") REFERENCES "team"("team_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "player" ADD CONSTRAINT "player_position_id_fkey" FOREIGN KEY ("position_id") REFERENCES "position"("position_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "match_prediction" ADD CONSTRAINT "match_prediction_user_league_id_fkey" FOREIGN KEY ("user_league_id") REFERENCES "user_league"("user_league_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "match_prediction" ADD CONSTRAINT "match_prediction_match_id_fkey" FOREIGN KEY ("match_id") REFERENCES "match"("match_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "match_prediction" ADD CONSTRAINT "match_prediction_first_try_scorer_id_fkey" FOREIGN KEY ("first_try_scorer_id") REFERENCES "player"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "competition_prediction" ADD CONSTRAINT "competition_prediction_user_league_id_fkey" FOREIGN KEY ("user_league_id") REFERENCES "user_league"("user_league_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "competition_prediction" ADD CONSTRAINT "competition_prediction_competition_id_fkey" FOREIGN KEY ("competition_id") REFERENCES "competition"("competition_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "competition_prediction" ADD CONSTRAINT "competition_prediction_top_try_scorer_id_fkey" FOREIGN KEY ("top_try_scorer_id") REFERENCES "player"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "competition_prediction" ADD CONSTRAINT "competition_prediction_top_points_scorer_id_fkey" FOREIGN KEY ("top_points_scorer_id") REFERENCES "player"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "point" ADD CONSTRAINT "point_user_league_id_fkey" FOREIGN KEY ("user_league_id") REFERENCES "user_league"("user_league_id") ON DELETE RESTRICT ON UPDATE CASCADE;
