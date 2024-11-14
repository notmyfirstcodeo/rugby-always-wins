import { Router } from "express";
import { getPoints } from "../controllers/pointController";

const router = Router();

router.get("/", getPoints);

export default router;
