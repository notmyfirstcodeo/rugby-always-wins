import { Router } from "express";
import { createLeague, getLeagues } from "../controllers/leagueController";

const router = Router();

router.get("/", getLeagues);
router.post("/", createLeague);

export default router;
